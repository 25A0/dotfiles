# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="terminalparty"
ZSH_THEME="mrtazz"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    brew
    catimg
    z
    bgnotify
    taskwarrior
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# If exa is installed, alias l to exa -l
hash exa 2>/dev/null && alias l="exa -l"

# Recommendations that I found on
# http://webdevstudios.com/2015/02/10/a-beginners-guide-to-the-best-command-line-tools/
# COMPLETION_WAITING_DOTS="true"
ZSH_HIGHTLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# # Fish-like suggestions:
# # Load zsh-syntax-highlighting.
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# # Load zsh-autosuggestions.
# source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# # Enable autosuggestions automatically.
# zle-line-init() {
#     zle autosuggest-start
# }
# zle -N zle-line-init

# Functions

# make available for download on uberspace
publish() {
	echo File URLs will be:
	for i in $@; do
		echo https://www.post-apocalyptic-crypto.org/downloads/files/${i}
	done
	scp $@ pluto:~/chicagoboss/homepage/static/files
}

# simple timer that sends three bells after a given time.

timer() {
    SECONDS=`expr    $1            % 100`
    MINUTES=`expr \( $1 /   100 \) % 100`
    HOURS=`  expr \( $1 / 10000 \) % 100`
    TOTAL_TIME=`expr $HOURS \* 3600 + $MINUTES \* 60 + $SECONDS`
    (\
     sleep ${TOTAL_TIME}; \
     printf "\a"; \
     sleep 1; \
     printf "\a"; \
     sleep 1; \
     printf "\a"; \
     sleep 1; \
     sed "1,1 d" -i="sedb" ~/.timer;\
     ) 2>/dev/null &
    TIMER_END=$(expr $(date +%s) + ${TOTAL_TIME})
    touch ~/.timer
    echo ${TIMER_END} | cat - ~/.timer | sort -n > ~/.timer
    printf "Timer started for %02d:%02d:%02dh, or %d second(s).\n" \
           ${HOURS} ${MINUTES} ${SECONDS} ${TOTAL_TIME}
}

# creates a new scratch directory and cds to it
scratch() {
	NAME=$(echo $(date) | md5sum )
	mkdir -p ~/.scratch/${NAME}
	cd ~/.scratch/${NAME}	
}

# return the URL that links to the given commit.
# this should work whenever the remote is a ssh remote
# i.e. something like git@github.com:user/repo
# and produces something like
# 	https://github.com/user/repo/commit/$1
# this currently works for github and gitlab, since they both use this url format
commiturl() {
	echo `git remote -v | head -n 1 | sed -E 's|^.*\s\S+@(.*):(.*).git\s.*|https://\1/\2/commit/|'`$1
}

export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

# Quick way to do stuff in bc
# Stolen from https://twitter.com/dsandler/status/786406879198978048
# Usage: = 4+12
function = { echo "$*" | tr ',' ';' | bc -l; }
# Zsh globbing gets upset about * for these cases, therefore:
setopt no_nomatch
# which suppresses an error when there was no match for *.

# Set defaults for host-specific tmux environment variables
# These values might be replaced in a host-specific rc file
tmux set-environment -g TMUX_HOSTNAME_FG "black"
tmux set-environment -g TMUX_HOSTNAME_BG "colour13"
tmux set-environment -g TMUX_HOST_STATUS_RIGHT ""

# Aliasseses

# Alias for attaching to the login tmux session
alias s='tmux new-session -A -s login'
alias emacs='TERM=screen-16color emacs -nw'
alias emacsclient='TERM=screen-16color emacsclient -nw'
alias gpgenc='gpg -a -s -e -r moritz@post-apocalyptic-crypto.org'
alias gpgdec='gpg -d'

NONLOGIN=`if [[ ! -o login ]]; then echo "> "; fi`
ROOT=$(if [[ `whoami` == 'root' ]]; then echo "%{$fg_bold[red]%} DANGERZONE %{$reset_color%}"; fi)
# Override default prompt
PROMPT='${ROOT}${NONLOGIN}%? %{$fg_bold[red]%}%m%{$reset_color%}:%{$fg[cyan]%}%c%{$reset_color%}:%# '
RPROMPT='%{$fg_bold[green]%} %{$fg_bold[green]%}$(command cat ~/.daily.txt 2>/dev/null || echo '')%{$reset_color%}%{$fg_bold[green]%} $(git_prompt_info)%{$reset_color%}${ROOT}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[yellow]%}x%{$fg[green]%}>%{$reset_color%}"

if [[ -e ~/.zsh-${HOST}-rc ]]; then
	# host-specific configuration
	source ~/.zsh-${HOST}-rc
fi

# If this is a login shell, list all current tmux sessions.
if [[ -o login ]]; then
    echo "tmux sessions:"
    tmux list-sessions
    echo -e "Type `tput bold`s`tput sgr0` to attach to the login session"
fi

function qr {
    FILENAME=`mktemp -t qrimg`
    FILENAME=${FILENAME}.png
    wget -O ${FILENAME} https://api.qrserver.com/v1/create-qr-code/\?size\=150x150\&data\=$1
    inline ${FILENAME}
}
