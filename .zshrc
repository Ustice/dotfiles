# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="muse"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git npm z jira)

# Powerline oh-my-zsh theme options
# https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme
POWERLINE_DATE_FORMAT="%D{%y%m%d}"
POWERLINE_DETECT_SSH="true"
POWERLINE_FULL_CURRENT_PATH="true"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_RIGHT_A="date"
POWERLINE_SHOW_GIT_ON_RIGHT="true"
POWERLINE_DETECT_SSH="true"

# For color names, see :
# http://unix.stackexchange.com/questions/105568/how-can-i-list-the-available-color-names

POWERLINE_SEC1_COLOR_FRONT="black"
POWERLINE_SEC1_COLOR_BACK="green"
POWERLINE_SEC1_ROOT_COLOR_FRONT="white"
POWERLINE_SEC1_ROOT_COLOR_BACK="red"
POWERLINE_PATH_COLOR_FRONT="white"
POWERLINE_PATH_COLOR_BACK="blue"

POWERLINE_GIT_COLOR_FRONT="white"
POWERLINE_GIT_COLOR_BACK="black"
# Time
POWERLINE_RIGHT_B_COLOR_FRONT="black"
POWERLINE_RIGHT_B_COLOR_BACK="white"
# Date
POWERLINE_RIGHT_A_COLOR_FRONT="black"
POWERLINE_RIGHT_A_COLOR_BACK="015"

# For changing the icons used
# Either comment out or set to "" for default
POWERLINE_GIT_CLEAN_COLOR="green"
POWERLINE_GIT_CLEAN_ICON="✔"
POWERLINE_GIT_DIRTY_COLOR="red"
POWERLINE_GIT_DIRTY_ICON="✘"
POWERLINE_GIT_ADDED_COLOR="green"
POWERLINE_GIT_ADDED_ICON="✚"
POWERLINE_GIT_MODIFIED_COLOR="blue"
POWERLINE_GIT_MODIFIED_ICON="✹"
POWERLINE_GIT_DELETED_COLOR="red"
POWERLINE_GIT_DELETED_ICON="✖"
POWERLINE_GIT_UNTRACKED_COLOR="yellow"
POWERLINE_GIT_UNTRACKED_ICON="✭"
POWERLINE_GIT_RENAMED_COLOR="yellow"
POWERLINE_GIT_RENAMED_ICON="➜"
POWERLINE_GIT_UNMERGED_COLOR=""
POWERLINE_GIT_UNMERGED_ICON="═"
POWERLINE_GIT_PROMPT_AHEAD_COLOR="yellow"
POWERLINE_GIT_PROMPT_AHEAD_ICON="⬆"
POWERLINE_GIT_PROMPT_BEHIND_COLOR="yellow"
POWERLINE_GIT_PROMPT_BEHIND_ICON="⬇"
POWERLINE_GIT_PROMPT_DIVERGED_COLOR="red"
POWERLINE_GIT_PROMPT_DIVERGED_ICON="⬍"

POWERLEVEL9K_MODE='awesome-fontconfig'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(node_version ip time )
POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
DEFAULT_USER=$USER
POWERLEVEL9K_TIME_FORMAT="%D{%Y.%m.%d @ %H:%M:%S}"

export TERM="xterm-256color"

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# User customizations
export PATH="/Users/jkleinberg/bin:$PATH"
# Android SDK
export PATH="/usr/local/Cellar/android-sdk/22.6.2/tools:$PATH"
# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"

export ANDROID_HOME="/usr/local/opt/android-sdk"

# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='atom'
fi

# For node-oracledb: https://github.com/oracle/node-oracledb/blob/a867a81ab73ae8238b7fdabbfcf380fdf2eab26d/INSTALL.md#instosx
export DYLD_LIBRARY_PATH=/opt/oracle/instantclient

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Adds ability to move cursor forward and back a word at a time
bindkey '^[^[[C' forward-word
bindkey '^[^[[D' backward-word


[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# Convienience commands
alias cpwd="pwd | tr '\n' ' ' | pbcopy"

# Git aliases
alias gs="git status $*"
alias gaa="git add -A :/$*"
alias gcm="git commit -m $*"
alias gf="git fetch $*"
alias gb="git symbolic-ref HEAD --short"
alias grbs="git rebase --skip"
export GITHUBUN="Ustice"

alias gdf="vcsh dotfiles"

alias debug="export NODE_DEBUG='verbose'"
alias prod="export NODE_DEBUG='silent'"
alias mobiledev="export NODE_IP_OVERRIDE='true'"
alias localdev="export NODE_IP_OVERRIDE=''"

alias simulator='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'

alias ccc="compass clean; compass compile"
alias cccw="compass clean; compass compile; compass watch"

alias bump="npm version minor"

# Sometimes my keys get removed from SSH, and this readds them.
ssh-add

# Project-specific
## Spider LMS
export PGDATA="/usr/local/var/postgres"
alias spider="cd /repos/MobSource/MobSource_SpiderLMS_Web"
export NODE_IP_OVERRIDE='true'

## MyMonopoly
export MM_LOCAL_DEV='true'

## Life-Map
export NODE_ENV="local"

## Angular Tuturial
export CHROME_BIN="/Applications/Google Chrome Dev.app/Contents/MacOS/Google Chrome"

## JWA
export NODE_PATH=/usr/local/lib/node_modules

## Homebrew search support
export HOMEBREW_GITHUB_API_TOKEN="81fdb82709bfab39f3915ccbf9433bbbc8025717"

## JENV (Multiple Java environmnent support)
export JENV_ROOT=/usr/local/var/jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

## iTerm 2/3 Shell integrations
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

## AWS
source ~/.awsrc

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
