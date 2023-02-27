#!/usr/bin/env sh
echo "Setting up your MacOS setup...\n"

# Get the full path to the dotfiles repo
DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Hide "last login" when starting a new terminal session
if [ ! -f "$HOME/.hushlogin" ]; then
    echo "Hiding last login..."

    touch $HOME/.hushlogin
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
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/usr/local/bin/brew shellenv)"
fi

echo "Installing dependencies..."
brew update
brew tap homebrew/bundle
brew bundle --file $DOTFILES/homebrew/Brewfile
brew cleanup

# Install global Composer packages
echo "Installing global composer packages..."
/usr/local/bin/composer global require laravel/installer laravel/valet laravel-zero/installer
# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install
$HOME/.composer/vendor/bin/valet trust

# Install node versions
echo "Installing latest node LTS..."
/usr/local/bin/fnm install --lts
/usr/local/bin/fnm default lts-latest

# Add global gitignore symlink
echo "Setting global gitignore..."
ln -sf $DOTFILES/git/gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile $HOME/.gitignore_global

# Create default code structure
echo "Creating default code structure..."
CODE=$HOME/Code
PB=$CODE/pressbooks
mkdir $CODE
mkdir $PB

# Clone basic repositories
echo "Cloning repositories..."
git clone git@github.com:pressbooks/bi-data-manager.git "$PB/bi-data-manager"
git clone git@github.com:pressbooks/pressbooks-book-directory-fe.git "$PB/pressbooks-directory"
git clone git@github.com:pressbooks/setup-development-environment.git "$PB/pressbooks-network"

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
