#!/usr/bin/env sh
echo "Setting up your MacOS setup...\n"

# Get the full path to the dotfiles repo
DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Hide "last login" when starting a new terminal session
if [ ! -f "$HOME/.hushlogin" ]; then
    echo "Hiding last login..."

    touch $HOME/.hushlogin
fi 

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed."
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Homebrew
if test ! $(which brew); then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing dependencies..."
brew update
brew tap homebrew/bundle
brew bundle --file $DOTFILES/homebrew/Brewfile
brew cleanup

# Add global gitignore symlink
echo "Setting global gitignore..."
ln -sf $DOTFILES/git/gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global

# Create default code structure
echo "Creating default code structure..."
CODE=$HOME/Code
PB=$CODE/pressbooks
SITES=$CODE/sites
mkdir $CODE
mkdir $PB
mkdir $SITES

# Clone basic repositories
echo "Cloning repositories..."
git clone git@github.com:pressbooks/bi-data-manager.git "$PB/bi-data-manager"
git clone git@github.com:pressbooks/pressbooks-book-directory-fe.git "$PB/pressbooks-directory"
git clone git@github.com:pressbooks/setup-development-environment.git "$PB/pressbooks-network"
git clone git@github.com:fdalcin/the-ink-crown.git "$SITES/the-ink-crown"

echo "Configuring terminal..."
rm -rf "$DOTFILES/zsh/themes/spaceship-prompt"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$DOTFILES/zsh/themes/spaceship-prompt" --depth=1
ln -sf "$DOTFILES/zsh/themes/spaceship-prompt/spaceship.zsh-theme" "$DOTFILES/zsh/themes/spaceship.zsh-theme"

rm -rf "$DOTFILES/zsh/plugins/fast-syntax-highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${DOTFILES}/zsh/plugins/fast-syntax-highlighting"

rm -rf "$DOTFILES/zsh/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions "${DOTFILES}/zsh/plugins/zsh-autosuggestions"

# Add symlink to zsh preferences
echo "Setting zsh preferences..."
ln -sf $DOTFILES/zsh/zshrc $HOME/.zshrc

# Symlink the Mackup config file to the home directory
echo "Setting MacOS preferences..."
ln -sf $DOTFILES/mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/misc/macos
