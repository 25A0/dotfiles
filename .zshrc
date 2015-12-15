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
plugins=(git brew catimg z zsh-syntax-highlighting bgnotify thefuck)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/crossgcc/bin:/usr/local/sbin:/Applications/Inkscape.app/Contents/Resources/bin:/Applications/sage:/usr/local/bin:/usr/texbin:/usr/local/Cellar:/usr/local/texlive/2014/bin/x86_64-darwin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export FPATH="/Users/moritz/.zsh-functions/:$FPATH"
autoload ytget
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


# The Fuck
eval $(thefuck --alias)

# Functions

# make available for download on uberspace
publish() {
	scp $@ pluto:~/chicagoboss/homepage/static/files && \
	for i in $@; do
		echo http://www.25a0.com/downloads/files/${i}
	done
}

# simple timer that shows a desktop notification
timer() {
	TIME=`expr 60 \* $1`
	(sleep ${TIME} && notifier '*beep beep* *beep beep*') & \
	echo 'Timer started for '$1' minute(s).'
}

export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

if [[ -e ~/.zsh-${HOST}-rc ]]; then
	# host-specific configuration
	source ~/.zsh-${HOST}-rc
fi
