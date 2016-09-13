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

CLEAR='\e[0m'
BOLD='\e[1m'

BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
PURPLE='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'

alias l="ls -laG --color"
alias ls="ls -G --color"

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
}

function set_prompt {
  local return_status_color=$GREEN
  if [[ ! $1 != 0 ]]; then
    return_status_color=$RED
  fi
  PS1="\[$BOLD$CYAN\]\W \[$BLUE\]\$(parse_git_branch) \[$return_status_color\]\$\[$CLEAR\] "
}
set_prompt

