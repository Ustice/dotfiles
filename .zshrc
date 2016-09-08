# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="powerlevel9k/powerlevel9k"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git npm z jira zsh-autosuggestions)

POWERLEVEL9K_MODE='awesome-fontconfig'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(node_version ip time )
POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
DEFAULT_USER=$USER
POWERLEVEL9K_TIME_FORMAT="%D{%Y.%m.%d @  %H:%M:%S}"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

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

alias bump="npm version minor"

# Sometimes my keys get removed from SSH, and this reads them.
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

## JWA
export NODE_PATH=/usr/local/lib/node_modules

## JENV (Multiple Java environmnent support)
export JENV_ROOT=/usr/local/var/jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

## iTerm 2/3 Shell integrations
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

## Homebrew search support
export HOMEBREW_GITHUB_API_TOKEN="PRIVATE"

## AWS
export AWS_ACCESS_KEY_ID="PRIVATE"
export AWS_SECRET_ACCESS_KEY="PRIVATE"
export AWS_DEFAULT_REGION="PRIVATE"
export AWS_ES_HOST="PRIVATE"

# Load private data
test -e ~/.zshrc-private && source ~/.zshrc-private

# NPM Tab completion
source <(npm completion)
