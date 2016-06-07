# debian base setup
# $ su
# $ apt-get install sudo
# $ add-user <username> sudo
# $ exit (logout and login)
# $ sudo apt-get install vim git build-essential xorg openbox
# $ sudo update-alternatives -–config editor (select vim)

# fedora base setup
# $ su
# $ sudo dnf install vim
# $ sudo vim /etc/sudoers
# <add line> "chemecse\tADD=(ADD)\tADD"
# $ exit
# $ sudo dnf install git gcc xorg-x11-\* openbox

# unarchive commands
# *.tar.bz2 -> tar xvjf <filename>
# *.tar.gz  -> tar xvzf <filename>
# *.tar.xz  -> tar xvJf <filename>
# *.bz2     -> bunzip2  <filename>
# *.rar     -> unrar x  <filename>
# *.gz      -> gunzip   <filename>
# *.tar     -> tar xvf  <filename>
# *.tbz2    -> tar xvjf <filename>
# *.tgz     -> tar xvzf <filename>
# *.zip     -> unzip    <filename>

# find file command
# $ find <directory> -name "<regex>"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

source ~/.git-completion.bash

readonly COLOR_OFF='\e[0m'
readonly COLOR_BLACK='\e[0;30m'
readonly COLOR_RED='\e[0;31m'
readonly COLOR_GREEN='\e[0;32m'
readonly COLOR_YELLOW='\e[0;33m'
readonly COLOR_BLUE='\e[0;34m'
readonly COLOR_PURPLE='\e[0;35m'
readonly COLOR_CYAN='\e[0;36m'
readonly COLOR_WHITE='\e[0;37m'

readonly COLOR_BLACK_BOLD='\e[1;30m'
readonly COLOR_RED_BOLD='\e[1;31m'
readonly COLOR_GREEN_BOLD='\e[1;32m'
readonly COLOR_YELLOW_BOLD='\e[1;33m'
readonly COLOR_BLUE_BOLD='\e[1;34m'
readonly COLOR_PURPLE_BOLD='\e[1;35m'
readonly COLOR_CYAN_BOLD='\e[1;36m'
readonly COLOR_WHITE_BOLD='\e[1;37m'

alias l="ls -laG --color"
alias ls="ls -G --color"

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
}

function set_prompt {
  local return_status_color=$COLOR_GREEN
  if [[ ! $1 != 0 ]]; then
    return_status_color=$COLOR_RED
  fi
  PS1="$COLOR_CYAN_BOLD\W $COLOR_BLUE_BOLD\$(parse_git_branch) $return_status_color\$$COLOR_OFF "
}
set_prompt

