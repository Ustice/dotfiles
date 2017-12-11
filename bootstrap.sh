#!/usr/bin/env bash

# if (( $EUID != 0 )); then
#     echo "In order to install system tools, this script must be run as root. Exiting."
#     exit
# fi

# Display commands as they are run
PS4='$LINENO: '
set -x

# helpers
function echo_ok { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error  { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

echo_ok "Install starting. You may be asked for your password (for sudo)."

USERNAME=$(logname) # Username (whoami would return 'root')

# Directories
REPO_ROOT="/repo" # repos
BINARIES="~/bin" # binaries

# Create repository directory
sudo mkdir $REPO_ROOT
chown $USERNAME $REPO_ROOT

# Accept XCode license
echo_ok "Accept the XCode License by pressing Q then accept."
sudo xcodebuild -license

# Install Homebrew
echo_ok "Installing Homebrew."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap caskroom/fonts
brew tap caskroom/versions

echo_ok "Installing terminal utilities."
brew install
  mongodb \
  node \
  vcsh \

echo_ok "Installing applications."
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

# Make sure that Dropbox is installed
# Installation: https://www.dropbox.com/install
while [ ! -d "~/Dropbox/.ssh" ]; do
    echo "I'm unable to find the .ssh directory in your Dropbox directory."
    echo "Please sign in to Dropbox, and allow it to sync to continue."
    read -rsn 1 =p "Press i to load the Dropbox installation site, and any other key to continue." SHOULD_INSTALL_DROPBOX

    if [ $SHOULD_INSTALL_DROPBOX = "i" ]; then
        open "https://www.dropbox.com/install"
    fi
done

# Restore ssh keys
echo_ok "Copying ssh keys"
sudo cp -r ~/Dropbox/bootstrap/.ssh ~/.ssh
cp -r ~/Dropbox/bootstrap/.zshrc-private

# Restoring Dot Files
echo_ok "Installing dotiles"
cd $REPO_ROOT
git clone git@github.com:Ustice/dotfiles.git
cp .atom ~
cp bin ~
cp .zshrc ~


# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$REPO_ROOT/.iterm_profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true