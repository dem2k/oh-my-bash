#! bash oh-my-bash.module
#  ---------------------------------------------------------------------------

# Directory Listing aliases
alias dir='ls -hFx'
alias ll='ls -laFh'             # Preferred 'ls' implementation
alias l.='ls -d .* --color=tty' # short listing, only hidden files - .*
alias l='ls -lFh'               # long, sort by newest to oldest
alias L='ls -latrhF'            # long, sort by oldest to newest
alias la='ls -AlF'              # show hidden files
alias lc='ls -lcr'              # sort by change time
alias lk='ls -lSr'              # sort by size
alias lh='ls -lSrh'             # sort by size human readable
alias lm='ls -al | more'        # pipe through 'more'
alias lo='ls -laSFh'            # sort by size largest to smallest
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lu='ls -lur'              # sort by access time

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

alias duh='du -h -d1 |sort -hr'    # Short and human-readable directory listing
alias duf='du -sh *'               # Short and human-readable file listing
alias dud='du -h -d1'
