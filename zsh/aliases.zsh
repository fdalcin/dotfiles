# Shortcuts
alias copyssh="cat < $HOME/.ssh/id_ed25519.pub | pbcopy"
alias reloadshell="source $HOME/.zshrc"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"

# Directories
alias dotfiles="cd $DOTFILES"

# Laravel
alias artisan="php artisan"
alias tinker="php artisan tinker"
alias seed="php artisan db:seed"
alias mfs="php artisan migrate:fresh --seed"
alias test="php artisan test"
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"

# PHP
alias larastan="vendor/bin/phpstan analyse"
alias phpunit="vendor/bin/phpunit"
alias pest="vendor/bin/pest"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nah="git reset --hard; git clean -df"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"

# IP addresses
alias ip="curl ifconfig.me/ip ; echo"

# Flush Directory Service cache
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv $HOME/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Restart touch bar
alias touchbar="killall ControlStrip"
