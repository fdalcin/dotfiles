# Introduction

These are my personal dotfiles, they help me set up and maintain my Mac by taking away the effort of installing everything manually. Feel free to explore, contribute and copy parts for your own dotfiles!

Backups of settings are done via [Mackup](https://github.com/lra/mackup).

The inspiration came from visiting the [GitHub does dotfiles](https://dotfiles.github.io) project. Other sources of inspiration were [Dries'](https://github.com/driesvints/dotfiles) and [Freek's](https://github.com/freekmurze/dotfiles) dotfiles repositories.

## Starting fresh

Follow the instructions below to set up new MacOS devices.

### Migrating from an existing Mac?

If you're migrating from an existing Mac, make sure to backup all your existing data first. Here's a helpful checklist to validate nothing is missing.

- Did you commit and push any changes/branches to your git repositories?
- Did you save all important documents from non cloud storage directories?
- Did you save all of your work from apps which aren't synced through cloud storage services?
- Did you export important data from your local database?
- Did you update [mackup](https://github.com/lra/mackup) to the latest version and ran `mackup backup`?

### Setting up your Mac

After backing up your data you may now follow these install instructions to setup a new one.

1. [Generate a new public and private SSH key](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) by running:
   ```zsh
   curl https://raw.githubusercontent.com/fdalcin/dotfiles/HEAD/misc/ssh.sh | sh -s "<your-email-address>"
   ```
2. Copy the newly created SSH key and [add it to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
3. Clone this repository to `~/.dotfiles` with:
    ```zsh
    git clone git@github.com:fdalcin/dotfiles.git ~/.dotfiles
    ```
4. Run the installation with:
    ```zsh
    cd ~/.dotfiles && ./install.sh
    ```
5. Start `Herd.app` and run its install process
6. After mackup is synced with your cloud storage, restore preferences by running `mackup restore`
7. Restart your computer to finalize the process

Your Mac should now be ready to use!

> **Note**
> You can use a different location other than `~/.dotfiles` if you want. Make sure you also update the reference in the [`zshrc`](./zsh/zshrc#L1) file.
