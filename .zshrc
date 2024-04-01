# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

autoload -Uz compinit
compinit -d ~/.config/zsh/.zcompdump

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    command-not-found
    git
    git-prompt
    gitignore
    rust
    safe-paste
    shrink-path
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6acad8,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

setopt HIST_IGNORE_SPACE

setopt nullglob

# Vi mode
bindkey -v
export KEYTIMEOUT=1
zle -N vi-mode-exit-blocklist
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
ZSH_VI_MODE_SET_CURSOR=true
ZSH_VI_MODE_CURSOR_NORMAL=2
ZSH_VI_MODE_CURSOR_VISUAL=6
ZSH_VI_MODE_CURSOR_INSERT=1
ZSH_VI_MODE_CURSOR_OPPEND=0

# Prompts.
autoload -Uz vcs_info
setopt prompt_subst

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '(%b)'
PROMPT='%B%F{green}%n@%m%f:%F{blue}$(shrink_path -f)%f%b'
PROMPT+='%B%F{green}${vcs_info_msg_0_}%f$%b '
RPROMPT='%*'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias d="distrobox enter dev"
alias b="distrobox enter dev"
alias e="exit"
alias gs=""
alias hist="history"
alias neofetch="~/Projects/GitHub/neofetch/./neofetch"
alias vi="nvim"
alias vim="nvim"
alias code="codium"
alias exot="exit"
alias exut="exit"
alias lua="lua5.4"
alias ts-node="npx ts-node"
alias pip="python3 -m pip"
alias pip3="python3 -m pip"
# alias "cargo run"="git restore . && cargo run"

# pnpm
export PNPM_HOME="/home/clint/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Exercism
export PATH=~/bin:$PATH

#[ -f "/home/clint/.ghcup/env" ] && source "/home/clint/.ghcup/env" # ghcup-env

# Starship prompt
eval "$(starship init zsh)"

# bun completions
[ -s "/home/clint/.bun/_bun" ] && source "/home/clint/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opam configuration
[[ ! -r /home/clint/.opam/opam-init/init.zsh ]] || source /home/clint/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f "/home/clint/.ghcup/env" ] && source "/home/clint/.ghcup/env" # ghcup-env
