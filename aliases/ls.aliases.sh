#! bash oh-my-bash.module
#  ---------------------------------------------------------------------------

# Directory Listing aliases
alias dir='ls -xFhv'
alias ll='ls -laFhv'               # Preferred 'ls' implementation
alias l.='ls -dFhv .* --color=tty' # short listing, only hidden files - .*
alias l='ls -lFh'                  # long, sort by newest to oldest
alias L='ls -latrFh'               # long, sort by oldest to newest
alias la='ls -AlFhv'               # show hidden files
alias lc='ls -lcrF'                # sort by change time
alias lk='ls -lSrF'                # sort by size
alias lh='ls -lSrFh'               # sort by size human readable
alias lm='ls -alFhv | more'        # pipe through 'more'
alias lo='ls -laSFhv'              # sort by size largest to smallest
alias lr='ls -lRFhv'               # recursive ls
alias lt='ls -ltrFhv'              # sort by date
alias lu='ls -lurFhv'              # sort by access time

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

alias duh='du -h -d1 |sort -hr'    # Short and human-readable directory listing
alias duf='du -sh *'               # Short and human-readable file listing
alias dud='du -h -d1'
