# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path au binaries
export PATH="$HOME/dotfiles_kickstarter/bin:$PATH"

# Oh my zsh pluggin

# Set name of the theme to load --- if set to "random", it will load a random theme each time 
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="terminalparty"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior zstyle 
zstyle ':omz:update' mode auto # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion. You can 
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? Standard plugins can be found in $ZSH/plugins/ Custom 
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete aliases 
alias-finder copypath gitfast jsontools python dirhistory vscode web-search)

source $ZSH/oh-my-zsh.sh

# User configuration

# les fonctions peuvent être mis directement ici
cc() {
    cat "$1" | xclip -selection clipboard
}

# Aliases:
alias py='python3' 
