#!/usr/bin/env bash

# if (( $EUID != 0 )); then
#     echo "In order to install system tools, this script must be run as root. Exiting."
#     exit
# fi

# Display commands as they are run
PS4='$LINENO: '
# set -ex
set e

echo "Install starting. You may be asked for your password (for sudo)."

USERNAME=$(logname) # Username (whoami would return 'root')

# Directories
REPO_ROOT="~/repos" # repos
BINARIES="~/bin" # binaries
SSH_KEYS="~/Dropbox/.ssh" # ssh key backup

# Create repository directory
sudo mkdir -p $REPO_ROOT
sudo chown $USERNAME $REPO_ROOT

echo "Checking Xcode license status"
# Accept XCode license
if (! xcode-select -p); then
  echo "Accept the XCode License by pressing Q then accept."
  xcode-select --install
  sudo xcodebuild -license
fi

# Install Homebrew
echo "Installing Homebrew."
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    mkdir -p /usr/local/homebrew
    cd /usr/local/homebrew
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
else
    brew update
fi

echo "Installing git large file storage"
if ( ! git lfs &> /dev/null ); then
  sudo git lfs install
  sudo git lfs install --system
fi

# Restoring Dot Files
echo "Installing dotiles"
cd $REPO_ROOT
if [ ! -e "$REPO_ROOT/dotfiles" ]; then
  git clone git@github.com:Ustice/dotfiles.git
fi

echo "Restoring configuration files"
ln -s "$REPO_ROOT/dotfiles/Brewfile" ~/Brewfile
ln -s "$REPO_ROOT/dotfiles/.zshrc" ~/.zshrc
ln -s "$REPO_ROOT/dotfiles/bin" ~/bin

echo "Installing applications and terminal utilities."
brew bundle install


IFS=''

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$REPO_ROOT/dotfiles/.iterm_profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Run installers
open /usr/local/Caskroom/lastpass/latest/LastPass\ Installer

# Open GoldenChaos-BTT installation documentation
echo "To install GoldenChaos-BTT Touchbar upgrade, please install from the opened page."
open "https://community.folivora.ai/t/goldenchaos-btt-a-complete-touch-bar-ui-replacement-preset/1281#heading--touch-bar-settings"

# This can take a while before Dropbox is ready, so it should likely always be the last step
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

echo "Please close your terminal session, and open a new one for the changes to be made."
