# If you come from bash you might have to change your $PATH. export
export PATH=$HOME/dotfilesx86/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add /opt/nvim-linux64/bin to PATH
export PATH="/opt/nvim-linux64/bin:$PATH"

# mes shell apps
export PATH="/$HOME/bashProjects/ShellTimer:$PATH" export 
PATH="/$HOME/flashcard:$PATH"

# Path à mes scripts
export PATH="$HOME/.dotfiles/bin:$PATH"

# Set name of the theme to load --- if set to "random", it will load a random theme each time 
# oh-my-zsh is loaded, in which case, to know which specific one was loaded, run: echo 
# $RANDOM_THEME See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="terminalparty"

# Set list of themes to pick from when loading at random Setting this variable when 
# ZSH_THEME=random will cause zsh to load a theme from this variable instead of looking in 
# $ZSH/themes/ If set to an empty array, this variable will have no effect. 
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case-sensitive 
# completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior zstyle 
# ':omz:update' mode disabled # disable automatic updates
zstyle ':omz:update' mode auto # update automatically without asking
# zstyle ':omz:update' mode reminder # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up. 
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls. DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title. 
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion. You can 
# also set it to another string to have that shown instead of the default red dots. e.g. 
# COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f" Caution: this setting can cause issues 
# with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files under VCS as 
# dirty. This makes repository status check for large repositories much, much faster. 
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time stamp shown 
# in the history command output. You can set one of the optional three formats: 
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or set a custom format using the strftime function 
# format specifications, see 'man strftime' for details. HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom? 
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? Standard plugins can be found in $ZSH/plugins/ Custom 
# plugins may be added to $ZSH_CUSTOM/plugins/ Example format: plugins=(rails git textmate 
# ruby lighthouse) Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete aliases 
alias-finder copypath gitfast jsontools python dirhistory vscode web-search)

source $ZSH/oh-my-zsh.sh

# fzf config:
# Set up fzf key bindings and fuzzy completion
#source <(fzf --zsh)

# GO path
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else export EDITOR='mvim'
# fi

# Compilation flags export ARCHFLAGS="-arch x86_64"

# mes scripts:

# recherche un terme de tes notes et ouvre le fichier avec neovim

search_notes() {
    local term="$1"

    if [[ -z "$term" ]]; then
        echo "Usage: search_notes <terme>"
        return 1
    fi

    rg --files-with-matches "$term" *.md | fzf | xargs -r nvim
}

cc() {
    cat "$1" | xclip -selection clipboard
}


mergeintomain() { git checkout main && git pull origin main && git merge "$1" && git push 
    origin main
}

rust() { if [ $# -eq 0 ]; then
        echo "Usage: rust_run <project_folder>" return 1
    fi

    local project_folder="$1"
    
    # Check if Cargo.toml exists in the provided project folder
    if [ ! -f "$project_folder/Cargo.toml" ]; then echo "Error: No Cargo.toml found in 
        $project_folder." return 1
    fi

    local main_project="$(basename "$(realpath "$project_folder")")"

    # Build and run the main project in the provided folder
    (cd "$project_folder" && cargo run --bin "$main_project")
}

createGitProject() {
    local github_username=$1
    local repository_name=$2

    # Check if the repository already exists on GitHub
    if gh repo view $github_username/$repository_name &>/dev/null; then 
        echo "Repository $github_username/$repository_name already exists on GitHub."
        return 1
    fi

    # Initialize Git repository locally with main as default branch
    git init 
    git symbolic-ref HEAD refs/heads/main
    git add . 
    git commit -m "Initial commit" --allow-empty

    # Create repository on GitHub
    gh repo create $github_username/$repository_name --private || return 1

    # Add GitHub repository as remote
    git remote add origin git@github.com:$github_username/$repository_name

    # Push to GitHub
    git push -u origin main || return 1

    echo "Git repository $repository_name successfully created on GitHub."
}

# Aliases:

alias py='python3' 
alias ach='python3 code.py add 1' 
alias arh='python3 rev.py add' 
alias cch='python3 code.py commit' 
alias gs='git status' 
alias ga='git add .' 
alias gc='git commit' 
alias c='clear' 
alias co='touch' 
alias de='vsc' 
alias yo='youtube' 
alias cookiecutter="~/.local/bin/cookiecutter" 
alias ja="javac Main.java && java Main" 
alias ij="intellij-idea-community" 
alias cpdf="libreoffice --convert-to pdf"
alias emac="emacsclient -c -a 'emacs'"
alias jac='find . -name "*.java" -exec javac -d ../bin {} + && java -cp ../bin $1'
alias disableMysql='sudo systemctl disable mysql'
alias stopMysql='sudo systemctl stop mysql'
alias restartMysql='sudo systemctl restart mysql'
alias startMysql='sudo systemctl start mysql'
alias initMysql='sudo systemctl enable mysql'
alias statusMysql='sudo systemctl status mysql'
alias mysqlWB='mysql-workbench-community'
alias loginMysql='sudo mysql -u root -p'
alias neofind='nvim $(fzf -m --preview="bat --color=always {}")'
alias dbfs='mysql -u root -p <'
alias venvPy='source ~/.venvs/venvPython/bin/activate'
# Alias to navigate to your project environment
alias lenvJs='cd /$HOME/.venvs/jsEnv/projects/ && echo "Switched to JavaScript environment: jsEnv"'

# Alias for global package installation
alias npminstallG='npm install -g'

# Alias for local package installation (from package.json)
alias npminstallL='npm install'


# Aliases for MariaDB
alias disableMariaDB='sudo systemctl disable mariadb'
alias stopMariaDB='sudo systemctl stop mariadb'
alias restartMariaDB='sudo systemctl restart mariadb'
alias startMariaDB='sudo systemctl start mariadb'
alias initMariaDB='sudo systemctl enable mariadb'
alias statusMariaDB='sudo systemctl status mariadb'
alias mariadbWB='mysql-workbench-community' # If using MySQL Workbench for MariaDB
alias loginMariaDB='sudo mariadb -u root -p'
alias mysqlAdmin='sudo mariadb-admin -u root -p'
alias backupMariaDB='sudo mysqldump -u root -p'
alias restoreMariaDB='sudo mysql -u root -p'
alias get_idf='. $HOME/esp/esp-idf/export.sh'
# scripts de démarrage

# activité du terminal au login 
startup() {
    echo "do you want to update? (y/n)" 
    read response
    if [ "$response" = "y" ]; then
        sudo apt update
        sudo apt upgrade
    fi
    neofetch
    echo ""
    echo "Bonjour `whoami`"
    echo ""
    echo "Cette session commence au: `date +"%Y-%m-%d %H:%M:%S"`"    
}
startup

PATH="/$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/$HOME/perl5"; export PERL_MM_OPT;
