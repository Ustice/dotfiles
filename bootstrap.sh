#!/usr/bin/env bash

# if (( $EUID != 0 )); then
#     echo "In order to install system tools, this script must be run as root. Exiting."
#     exit
# fi

# Display commands as they are run
PS4='$LINENO: '
set -ex

echo "Install starting. You may be asked for your password (for sudo)."

USERNAME=$(logname) # Username (whoami would return 'root')

# Directories
REPO_ROOT="/repos" # repos
BINARIES="~/bin" # binaries
SSH_KEYS="~/Dropbox/.ssh" # ssh key backup

# Create repository directory
sudo mkdir -p $REPO_ROOT
sudo chown $USERNAME $REPO_ROOT

# Accept XCode license
echo "Accept the XCode License by pressing Q then accept."
if (! xcode-select -p); then
  xcode-select --install
  sudo xcodebuild -license
fi

# Install Homebrew
echo "Installing Homebrew."
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi
brew tap caskroom/cask
brew tap caskroom/fonts
brew tap caskroom/versions

echo "Installing terminal utilities."
declare -a homebrew_apps=(
  "jenv"
  "mongodb"
  "node"
  "rbenv"
  "vcsh"
  "zsh"
)

for homebrew_app in "${homebrew_apps[@]}"; do
  if (! brew ls $homebrew_app); then
    echo "Installing $homebrew_app"
    brew install $homebrew_app
  else
    echo "$homebrew_app is already installed... skipping."
  fi
done

echo "Installing applications."
declare -a apps=(
  "atom"
  "bettertouchtool"
  "caprine"
  "dropbox"
  "epubquicklook"
  "flux"
  "font-source-code-pro-for-powerline"
  "google-chrome"
  "google-chrome-canary"
  "lastpass"
  "qlcolorcode"
  "qlimagesize"
  "qlmarkdown"
  "qlprettypatch"
  "qlstephen"
  "quicklook-csv"
  "quicklook-json"
  "skitch"
  "slack"
  "spotify"
  "the-unarchiver"
)

for app in "${apps[@]}"; do
  if (! brew cask ls $app); then
    echo "Installing $app"
    brew cask install $app
  else
    echo "$app is already installed... skipping."
  fi
done


# Set zsh as the default shell
if ! grep -Fxq "/usr/local/bin/zsh" /etc/shells; then
  sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells' && sudo chsh -s /usr/local/bin/zsh $(whoami)  
fi
# PowerLevel9K theme
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

IFS=''

# Make sure that Dropbox is installed and ready
until [[ -e ~/Dropbox/.ssh/id_rsa ]]; do
    echo "I'm unable to find the .ssh directory in your Dropbox directory."
    echo "Please sign in to Dropbox, and allow it to sync to continue."
    read -rsn 1 -t 1 -p "Press Enter to open Dropbox, and any other key to continue." KEY_PRESSED

    if [[ "$KEY_PRESSED" == $'\x0a' ]]; then
        open /Applications/Dropbox.app
    fi

    sleep 5
done

# Restore ssh keys
echo "Copying ssh keys"
sudo cp -R ~/Dropbox/bootstrap/.ssh ~
cp ~/Dropbox/bootstrap/.zshrc-private ~

# Restoring Dot Files
echo "Installing dotiles"
cd $REPO_ROOT
if [ ! -e "$REPO_ROOT/dotfiles" ]; then
  git clone git@github.com:Ustice/dotfiles.git
fi

cd dotfiles
cp -fR .atom ~
find ./bin -type f -maxdepth 1 -exec cp {} ~/bin \;
cp -f .zshrc ~

echo "Installing PowerLevel9k"
if [ ! -e ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$REPO_ROOT/dotfiles/.iterm_profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "Please close your terminal session, and open a new one for the changes to be made."

# Run installers
open /usr/local/Caskroom/lastpass/latest/LastPass\ Installer