# PATH hygiene
export PATH="/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Volta (Node toolchain manager)
export VOLTA_HOME="$HOME/.volta"
[ -d "$VOLTA_HOME/bin" ] && export PATH="$VOLTA_HOME/bin:$PATH"

# fzf
[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"

# git subcommands
alias gb='git branch'
alias gc='git checkout'
alias gp='git pull'
alias gph='git push'
alias gs='git stash'
alias gsa='git stash apply'
alias gr="git rebase"
