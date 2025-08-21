extract() {
  if [[ $# -eq 0 ]]; then
    cat >&2 <<'EOF'
Usage: extract [-option] [file ...]

Options:
    -r, --remove    Remove archive after unpacking.
EOF
    return 1
  fi

  local remove_archive=1
  if [[ "$1" == "-r" || "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  local pwd="$PWD"
  while [[ $# -gt 0 ]]; do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" >&2
      shift
      continue
    fi

    local success=0
    local file="$1" full_path="$(realpath "$1")"
    local extract_dir="${file%.*}"

    if [[ "${extract_dir}" =~ ".tar$" ]]; then
      extract_dir="${extract_dir%.*}"
    fi

    if [[ -e "$extract_dir" ]]; then
      local rnd="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)"
      extract_dir="${extract_dir}-${rnd}"
    fi

    mkdir -p "$extract_dir"
    cd "$extract_dir" || return
    echo "extract: extracting to $extract_dir" >&2

    case "${file,,}" in
      *.tar|*.tar.lzma|*.tlz|*.tar.zst|*.tzst|*.cbt|*.tar.lz) tar -axvf "$full_path" ;;
      *.tar.gz|*.tgz) [[ $(command -v pigz) ]] && tar -I pigz -xvf "$full_path" || tar -axvf "$full_path" ;;
      *.tar.bz2|*.tbz|*.tbz2) [[ $(command -v pbzip2) ]] && tar -I pbzip2 -xvf "$full_path" || tar -axvf "$full_path" ;;
      *.tar.xz|*.txz) [[ $(command -v pixz) ]] && tar -I pixz -xvf "$full_path" || tar -axvf "$full_path" || xzcat "$full_path" | tar xvf - ;;
      *.tar.lz4) lz4 -c -d "$full_path" | tar -xvf - ;;
      *.tar.lrz) [[ $(command -v lrzuntar) ]] && lrzuntar "$full_path" ;;
      *.gz)   [[ $(command -v pigz) ]] && pigz -cdk "$full_path" > "${file%.*}" || gunzip -ck "$full_path" > "${file%.*}" ;;
      *.bz2)  [[ $(command -v pbzip2) ]] && pbzip2 -d "$full_path" || bunzip2 "$full_path" ;;
      *.xz)   unxz "$full_path" ;;
      *.lrz)  lrunzip "$full_path" ;;
      *.lz4)  lz4 -d "$full_path" ;;
      *.lzma) unlzma "$full_path" ;;
      *.z)    uncompress "$full_path" ;;
      *.cbz|*.epub|*.zip) unzip "$full_path" ;;
      *.rar|*.cbr) unrar x -ad "$full_path" ;;
      *.rpm) rpm2cpio "$full_path" | cpio --quiet -id ;;
      *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar|*.vhd) 7z x "$full_path" ;;
      *.deb)
        mkdir -p "control" "data"
        ar vx "$full_path" > /dev/null
        (cd control && extract ../control.tar.*)
        (cd data && extract ../data.tar.*)
        rm -f *.tar.* debian-binary
        ;;
      *.zst) unzstd --stdout "$full_path" > "${file%.*}" ;;
      *.cab|*.exe) cabextract "$full_path" ;;
      *.cba|*.ace) unace x "$full_path" ;;
      *.arc)       arc e "$full_path" ;;
      *.cso)       ciso 0 "$full_path" "$full_path.iso" && extract "$full_path.iso" && rm -f "$full_path" ;;
      *.cpio|*.obscpio) cpio -idmvF "$full_path" ;;
      *.zpaq) zpaq x "$full_path" ;;
      *.zlib) zlib-flate -uncompress < "$full_path" > "${file%.*}" ;;
      *.dmg)
           mnt_dir=$(mktemp -d)
           hdiutil mount "$full_path" -mountpoint "$mnt_dir"
           echo "Mounted at: $mnt_dir" ;;
      *)
        echo "extract: '$file' cannot be extracted" >&2
        success=1 ;;
    esac

    if [[ $success -eq 0 && $remove_archive -eq 0 ]]; then
      rm "$full_path"
    fi
    shift
    cd "$pwd" || return
  done
}
