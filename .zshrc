# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="powerlevel9k/powerlevel9k"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Note that zsh-syntax-highlighting needs to be last to function
plugins=(git npm z jira zsh-autosuggestions zsh-syntax-highlighting)

POWERLEVEL9K_MODE='awesome-fontconfig'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(battery node_version ip custom_wifi_signal time )
POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
DEFAULT_USER=$USER
# POWERLEVEL9K_TIME_FORMAT="%D{%Y.%m.%d @ %H:%M:%S}"
POWERLEVEL9K_TIME_FORMAT="\uf073 %D{%Y.%m.%d \uf017 %H:%M:%S}"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="235"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="white"

zsh_wifi_signal(){
  local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I) 
  local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

  if [ "$airport" = "Off" ]; then
    local color='%F{yellow}'
    echo -n "%{$color%}Wifi Off"
  else
    local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
    local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
    local color='%F{yellow}'

    [[ $speed -gt 100 ]] && color='%F{green}'
    [[ $speed -lt 50 ]] && color='%F{red}'

    # echo -n "%{$color%}$ssid $speed Mb/s%{%f%}" # removed char not in my PowerLine font 
    echo -n "%{$color%}$ssid%{%f%}" # removed char not in my PowerLine font 
  fi
}

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
# Ruby gems
export PATH="/usr/local/lib/ruby/gems/2.3.0:$PATH"
# Chef gems
export PATH="/Users/jkleinberg/.chefdk/gem/ruby/2.3.0/bin:$PATH"
# Adds Python (AWS CLI)
export PATH="~/Library/Python/3.6/bin:$PATH"
# yarn
export PATH="$HOME/.yarn/bin:$PATH"
# Mongo 3.4
export PATH="/usr/local/opt/mongodb@3.4/bin:$PATH"

# Android SDK
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
alias cpwd="pwd | tr -d '\n' | pbcopy"

# Git aliases
alias gs="git status --short"
alias gaa="git add -A :/$*"
alias gcm="git commit -m $*"
alias gf="git fetch $*"
alias gb="git symbolic-ref HEAD --short"
alias grbs="git rebase --skip"
export GITHUBUN="Ustice"
alias cb="gb | tr -d '\n' | pbcopy"
alias prune="git branch | grep "/" | xargs git branch -D"

alias copy="tr -d '\n' | pbcopy"

alias gdf="vcsh dotfiles"

alias debug="export NODE_DEBUG='verbose'"
alias prod="export NODE_DEBUG='silent'"
alias mobiledev="export NODE_IP_OVERRIDE='true'"
alias localdev="export NODE_IP_OVERRIDE=''"

alias simulator='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'

alias bump="npm version minor"
alias weather="curl -sS https://radar.weather.gov/Conus/Loop/southeast_loop.gif | imgcat && ansiweather"
alias forecast="curl -sS http://wttr.in/32601"

# Sometimes my keys get removed from SSH, and this reads them.
ssh-add

# Used for the standup utility
export NOTES="/Users/jkleinberg/Dropbox/.notes"

function standup(){
  if [ -z "$1" ]; then
    mdless $NOTES -P
  elif [ "$1" == "list" ]; then
    mdless $NOTES -lP --no-color | grep "^ \S" --color=never
  else
    mdless $NOTES -s $1 -P
  fi
}

function trim() {
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"   # remove leading whitespace characters
    var="${var%"${var##*[![:space:]]}"}"   # remove trailing whitespace characters
    echo -n "$var"
}

## Node Development Environment
export NODE_ENV="development"

# Project-specific
## Spider LMS
export PGDATA="/usr/local/var/postgres"
export NODE_IP_OVERRIDE='true'

## MyMonopoly
export MM_LOCAL_DEV='true'

## JWA
export NODE_PATH=/usr/local/lib/node_modules

### AWS
# export AWS_ACCESS_KEY_ID="PRIVATE"
# export AWS_SECRET_ACCESS_KEY="PRIVATE"
# export AWS_DEFAULT_REGION="PRIVATE"
# export AWS_ES_HOST="PRIVATE"


# JENV (Multiple Java environmnent support)
export JENV_ROOT=/usr/local/var/jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# iTerm 2/3 Shell integrations
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# Homebrew search support
export HOMEBREW_GITHUB_API_TOKEN="PRIVATE"

# Load private data
test -e ~/.zshrc-private && source ~/.zshrc-private

# NPM Tab completion
source <(npm completion)

# rbenv
eval "$(rbenv init -)"
