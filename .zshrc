# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# local LOCAL_PWD
# LOCAL_PWD=$(pwd)
# export TERM="xterm-256color"
# # export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# export ZSH="$HOME/.oh-my-zsh"

# # Set name of the theme to load.
# # Look in ~/.oh-my-zsh/themes/
# # ZSH_THEME="powerlevel9k/powerlevel9k"

# ccl(){
#   echo -ne "\033[2K\r"
# }

# source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# # Note that zsh-syntax-highlighting needs to be last to function
# echo -ne "Loading zsh plugins..."
# plugins=(
#   aws
#   brew
#   # cpanm
#   docker
#   docker-compose
#   # dotenv
#   git
#   gulp
#   npm
#   # perl
#   # thefuck
#   # jira
#   z
#   zsh-autosuggestions
#   # zsh-interactive-cd # Removed in favor of fig
#   zsh-navigation-tools

# # This must remain the last plugin
#   zsh-syntax-highlighting
# )

# POWERLEVEL9K_MODE='awesome-fontconfig'

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs )
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(battery node_version ip custom_wifi_signal time )
# POWERLEVEL9K_STATUS_VERBOSE=false
# # POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# # POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
# DEFAULT_USER=$USER
# # POWERLEVEL9K_TIME_FORMAT="%D{%Y.%m.%d @ %H:%M:%S}"
# POWERLEVEL9K_TIME_FORMAT="\uf073 %D{%Y.%m.%d \uf017 %H:%M:%S}"
# POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

# POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
# POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="235"
# POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="white"

# zsh_wifi_signal(){
#   local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
#   local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

#   if [ "$airport" = "Off" ]; then
#     local color='%F{yellow}'
#     echo -n "%{$color%}Wifi Off"
#   else
#     local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
#     local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
#     local color='%F{yellow}'

#     [[ $speed -gt 100 ]] && color='%F{green}'
#     [[ $speed -lt 50 ]] && color='%F{red}'

#     # echo -n "%{$color%}$ssid $speed Mb/s%{%f%}" # removed char not in my PowerLine font
#     echo -n "%{$color%}$ssid%{%f%} " # removed char not in my PowerLine font
#   fi
# }

# # User configuration

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/jason.kleinberg/repos/dotfiles/bin"
# # User customizations
# export PATH="/Users/jason.kleinberg/bin:$PATH"
# # Android SDK
# # export PATH="/usr/local/Cellar/android-sdk/22.6.2/tools:$PATH"
# # Heroku Toolbelt
# # export PATH="/usr/local/heroku/bin:$PATH"
# # Ruby gems
# export PATH="/usr/local/lib/ruby/gems/2.3.0:$PATH"
# # Chef gems
# export PATH="/Users/jason.kleinberg/.chefdk/gem/ruby/2.3.0/bin:$PATH"
# # Adds Python (AWS CLI)
# export PATH="~/Library/Python/3.6/bin:$PATH"
# # yarn
# export PATH="$HOME/.yarn/bin:$PATH"
# # Mongo 3.4
# export PATH="/usr/local/opt/mongodb@3.4/bin:$PATH"
# # Visual Studio Code
# export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
# # iTerm2 shell integratons
# export PATH="/Users/jason.kleinberg/.iterm2:$PATH"
# # zsh integrations
# export PATH="/usr/local/share/zsh/site-functions:$PATH"

# # AWS Session Manager plugin
# export PATH="/Users/jason.kleinberg/repos/bidx-graphql/sessionmanager-bundle/bin:$PATH"

# # Android SDK
# export ANDROID_HOME="/usr/local/opt/android-sdk"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
#   export VISUAL='vim'
# else
#   export EDITOR='vim'
# fi

# # For node-oracledb: https://github.com/oracle/node-oracledb/blob/a867a81ab73ae8238b7fdabbfcf380fdf2eab26d/INSTALL.md#instosx
# export DYLD_LIBRARY_PATH=/opt/oracle/instantclient

# [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# ccl
# echo -ne "Setting aliases..."

# # Convienience commands
# alias cpwd="pwd | tr -d '\n' | pbcopy"

# alias gdf="vcsh dotfiles"
# alias gcu="git commit --amend --no-edit"

# alias debug="export NODE_DEBUG='verbose'"
# alias prod="export NODE_DEBUG='silent'"
# alias mobiledev="export NODE_IP_OVERRIDE='true'"
# alias localdev="export NODE_IP_OVERRIDE=''"

# alias simulator='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'

# alias bump="npm version minor"
# alias weathermap="curl -sS https://radar.weather.gov/ridge/standard/SOUTHEAST_loop.gif"
# alias radar="weathermap | imgcat --height $(($(tput lines)-2)) && ansiweather"
# alias weather="ansiweather"
# # alias forecast="curl -sS http://wttr.in/32601"
# alias ts="curl -sS https://www.nhc.noaa.gov/xgtwo/two_atl_5d0.png | imgcat --height $(($(tput lines)-2))"

# alias cz="echo 'zoommtg://zoom.us/join?confno=9565361682' | pbcopy"

# # Restore Graphics Magick alias
# alias gm="/usr/local/Cellar/graphicsmagick/1.3.30/bin/gm $*"

# # Reset Bluetooth
# alias rb="sudo kill -9 `ps ax | grep 'coreaudiod' | grep -v grep | awk '{print $1}'`"

# # Docker
# alias dc="docker compose $*"
# alias dce="docker compose exec $*"
# alias dcr="docker-compose run --rm $*"

# # AWS
# # alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'

# # Sometimes my keys get removed from SSH, and this reads them.
# # ssh-add

# # Used for the standup utility
# export NOTES="/Users/jason.kleinberg/.notes"

# function standup(){
#   if [ -z "$1" ]; then
#     mdless $NOTES -P
#   elif [ "$1" == "list" ]; then
#     mdless $NOTES -lP --no-color | grep "^ \S" --color=never
#   else
#     mdless $NOTES -s $1 -P
#   fi
# }

# function trim() {
#     local var="$*"
#     var="${var#"${var%%[![:space:]]*}"}"   # remove leading whitespace characters
#     var="${var%"${var##*[![:space:]]}"}"   # remove trailing whitespace characters
#     echo -n "$var"
# }

# function keep-trying() {
#   number_pattern="^[0-9]+$"
#   delay=2
#   command=$@

#   if [[ $1 =~ $number_pattern ]]; then
#     delay=$1
#     command="${*:2}"
#   fi

#   until `command`; do sleep $delay; done
# }

# ## Node Development Environment
# export NODE_ENV="development"

# # Project-specific
# export PGDATA="/usr/local/var/postgres"
# export NODE_IP_OVERRIDE='true'

# ## Set Bat theme
# export BAT_THEME="Monokai Extended"

# ### AWS
# # export AWS_ACCESS_KEY_ID="PRIVATE"
# # export AWS_SECRET_ACCESS_KEY="PRIVATE"
# # export AWS_DEFAULT_REGION="PRIVATE"
# # export AWS_ES_HOST="PRIVATE"

# # JENV (Multiple Java environmnent support)
# # ccl
# # echo -ne "Setting Java environment support..."
# # export JENV_ROOT=/usr/local/var/jenv
# # if which jenv > /dev/null; then eval "$(jenv init -)"; fi
# # export PATH="$HOME/.jenv/bin:$PATH"
# # eval "$(jenv init -)"

# ccl
# echo -ne 'Loading oh-my-zsh...'
# cd $ZSH
# source oh-my-zsh.sh
# cd ~

# ccl
# echo -ne 'Settings aliases...'

# # Git aliases
# alias gs='git status --short'
# alias gaa='git add -A :/$*'
# alias gcm='git commit -m $*'
# alias gf='git fetch $*'
# alias gb='git symbolic-ref HEAD --short'
# alias gpcb='git push --set-upstream origin $(gb)'
# alias gucb='git commit -a --amend --no-edit && git push origin $(git symbolic-ref HEAD --short)'
# alias grbs='git rebase --skip'
# export GITHUBUN="Ustice"
# alias cb="gb | tr -d '\n' | pbcopy"
# alias prune='git branch | grep '/" | xargs git branch -D"

# alias copy='tr -d "\n" | pbcopy'

# # ccl
# # echo -ne "Loading iterm2 integrations"
# # # iTerm 2/3 Shell integrations
# # test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
# # unalias imgcat

# # Homebrew search support
# export HOMEBREW_GITHUB_API_TOKEN='PRIVATE'

# # `brew file` for Homebrew
# # if [ -f $(brew --prefix)/etc/brew-wrap ];then
# #   source $(brew --prefix)/etc/brew-wrap
# # fi

# # Load private data
# ccl
# echo -ne 'Loading private data...'
# test -e ~/.zshrc-private && source ~/.zshrc-private

# # NPM Tab completion
# ccl
# echo -ne 'Installing npm autocompletions...'
# source <(npm completion)

# # rbenv
# # ccl
# # echo -ne "Setting Ruby environment..."
# # eval "$(rbenv init -)"

# # Loads The Fuck (https://github.com/nvbn/thefuck)
# # ccl
# # echo -ne "Loading The F___..."
# # eval $(thefuck --alias)

# # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ccl
# echo -ne "Setting Perl environment..."
# export PERL5LIB="/Users/jason.kleinberg/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
# export PERL_LOCAL_LIB_ROOT="/Users/jason.kleinberg/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
# export PERL_MB_OPT="--install_base \"/Users/jason.kleinberg/perl5\""
# export PERL_MM_OPT="INSTALL_BASE=/Users/jason.kleinberg/perl5"

# # ccl
# # echo -ne "Setting up pipx completions..."
# # autoload -U bashcompinit
# # bashcompinit
# # eval "$(register-python-argcomplete pipx)"

# # ccl
# # echo -ne "Installing fuzzy finder..."
# # [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ccl
# echo "Session ready."

# # cds
# cd "$LOCAL_PWD"
# pwd

# # bun completions
# [ -s "/Users/jason.kleinberg/.bun/_bun" ] && source "/Users/jason.kleinberg/.bun/_bun"

# # bun
# export BUN_INSTALL="/Users/jason.kleinberg/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
