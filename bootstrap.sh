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
REPO_ROOT="/repo" # repos
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
brew install \
  mongodb \
  node \
  vcsh \

echo "Installing applications."
brew cask install \
  atom \
  bettertouchtool \
  dropbox \
  epubquicklook \
  flux \
  font-source-code-pro-for-powerline \
  google-chrome \
  google-chrome-canary \
  lastpass \
  qlcolorcode \
  qlimagesize \
  qlmarkdown \
  qlprettypatch \
  qlstephen \
  quicklook-csv \
  quicklook-json \
  skitch \
  slack \
  spotify \
  the-unarchiver \

# ZSH
brew install zsh
# Set zsh as the default shell
sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s /usr/local/bin/zsh
# PowerLevel9K theme
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Make sure that Dropbox is installed and ready
until [ -f "$SSH_KEYS/id_rsa" ]; do
    echo "I'm unable to find the .ssh directory in your Dropbox directory."
    echo "Please sign in to Dropbox, and allow it to sync to continue."
    read -rsn 1 -p "Press Enter to open Dropbox, and any other key to continue." SHOULD_OPEN_DROPBOX

    if [[ $SHOULD_OPEN_DROPBOX == "" ]]; then
        open /Applications/Dropbox.app
    fi

    sleep 5
done

# Restore ssh keys
echo "Copying ssh keys"
sudo cp -r ~/Dropbox/bootstrap/.ssh ~/.ssh
cp -r ~/Dropbox/bootstrap/.zshrc-private

# Restoring Dot Files
echo "Installing dotiles"
cd $REPO_ROOT
git clone git@github.com:Ustice/dotfiles.git
cp .atom ~
cp bin ~
cp .zshrc ~


# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$REPO_ROOT/.iterm_profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true