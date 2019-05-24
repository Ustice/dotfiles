#!/usr/bin/env bash

# if (( $EUID != 0 )); then
#     echo "In order to install system tools, this script must be run as root. Exiting."
#     exit
# fi

# Display commands as they are run
# PS4='$LINENO: '
# set -ex
set e

echo "Install starting. You may be asked for your password (for sudo)."

USERNAME=$(logname) # Username (whoami would return 'root')

# Directories
REPO_ROOT="/repos" # repos
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
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi
brew tap caskroom/cask
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap theseal/ssh-askpass

echo "Installing terminal utilities."
declare -a homebrew_apps=(
  "ansiweather"
  "bat"
  "git-lfs"
  "gpg"
  "ical-buddy" # Required for GoldenChaos-BTT
  "jenv"
  "jq"
  "lastpass-cli --with-pinentry --with-doc"
  "mas"
  "mongodb"
  "node"
  "rbenv"
  "thefuck"
  "tldr"
  "vcsh"
  "yarn"
  "zsh"
)

for homebrew_app in "${homebrew_apps[@]}"; do
  if ( ! brew ls $homebrew_app &> /dev/null ); then
    echo "Installing $homebrew_app"
    brew install $homebrew_app
  else
    echo "$homebrew_app is already installed... skipping."
  fi
done

echo "Installing git large file storage"
if ( ! git lfs &> /dev/null ); then
  sudo git lfs install
  sudo git lfs install --system
fi

echo "Installing applications."
declare -a apps=(
  "aerial"
  "airserver"
  "alfred"
  "atom"
  "bettertouchtool"
  "caprine"
  "charles-applejava"
  "cyberduck"
  "docker"
  "dropbox"
  "duet"
  "epubquicklook"
  "flux"
  "font-droid-sans-mono-for-powerline"
  "font-input"
  "font-source-code-pro-for-powerline"
  "font-fira-code"
  "github"
  "google-chrome-canary"
  "google-chrome"
  "highsierramediakeyenabler" # Required for GoldenChaos-BTT
  "java8"
  "karabiner-elements"
  "lastpass"
  "licecap"
  "near-lock"
  "postman"
  "qlcolorcode"
  "qlimagesize"
  "qlmarkdown"
  "qlprettypatch"
  "qlstephen"
  "quicklook-csv"
  "quicklook-json"
  "robo-3t"
  "slack"
  "spotify"
  "ssh-askpass"
  "the-unarchiver"
  "visual-studio-code"
  "virtualbox"
  "vlc"
)

for app in "${apps[@]}"; do
  if ( ! brew cask ls $app &> /dev/null ); then
    echo "Installing $app"
    brew cask install $app
  else
    echo "$app is already installed... skipping."
  fi
done

# To find these ids, use the `mas list` command
echo "Installing App Store applications"
declare -a app_store_apps=(
"563362017"  # CloudClip Manager
"668429425"  # Downcast
"682658836"  # GarageBand
"408981434"  # iMovie
"1039633667" # Irvue
"409183694"  # Keynote
"926036361"  # LastPass
"409203825"  # Numbers
"409201541"  # Pages
"547067197"  # Push To Talk
"425955336"  # Skitch
"497799835"  # Xcode
)

for mac_app in "${app_store_apps[@]}"; do
  if (! mas list | grep $mac_app &> /dev/null ); then
    echo "Installing $mac_app"
    mas install $mac_app
  else
    echo "$mac_app is already installed... skipping."
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

# Open GoldenChaos-BTT installation documentation
echo "To install GoldenChaos-BTT Touchbar upgrade, please install from the opened page."
open "https://community.folivora.ai/t/goldenchaos-btt-a-complete-touch-bar-ui-replacement-preset/1281#heading--touch-bar-settings"
