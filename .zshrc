# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="terminalpartyedit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

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
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(z zsh-syntax-highlighting zsh-autosuggestions)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"
# export MANPATH="/usr/local/man:$MANPATH"


# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# export PATH

##pipsi install addition to the path variable
# export PATH="/Users/abinsimon/.local/bin:$PATH"

# . `brew --prefix`/etc/profile.d/z.sh

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

#enabling pandoc and lunx to make reading .md files in terminal
#To read do : rmd file.md
rmd () {
  pandoc $1 | lynx -stdin
}

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

# Custom

echo ""
fortune -s | fmt -c -w $COLUMNS
echo ""

eval $(thefuck --alias)

# Use vi mode in zshell
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
export KEYTIMEOUT=1

# Alias
alias ss='ls -lht'
alias ll='ls -A -l'
alias l='ls'
alias la='ls -A'
alias lr='ls -lRht'
alias c='clear'
alias q="exit"
alias :q="exit"
alias mkdir='mkdir -p'
alias o='open .'
alias rm='trash'
alias ffind='find . -name'
alias ..='cd ..'
# Check evey single file for a specific text and print surrounding 2 lines
alias here='find . -type f -print0|xargs -0 grep -C 2 -i'
alias server='python -m SimpleHTTPServer '
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias r='ranger'

# Alias to open multimedia folder in finder
alias m='cd ~/Documents/Multimedia && open . && cd -'
# Alias to get into project folder
alias p='cd ~/Documents/Projects && ls'
# Alias to get into desktop folder
alias d='cd ~/Desktop && ls'

# pretty code viewer
function code_view(){
	pygmentize $1 > /tmp/hilighted_code
	if [ $? -eq 0 ];
	then
		less /tmp/hilighted_code
	else
		less $1
	fi
	}
alias cl='code_view'

# cd with ls
function cdls(){
	cd $1
	ls
}
alias cd='cdls'

#polly-node
alias polly='sh ~/bin/polly_node.sh'

# extras
alias resetpacman='rm /var/lib/pacman/db.lck'

# Functions - mostly git
get_git_files_changed(){
	git status --short | grep -v ' D ' | grep -v '?? ' | sed 's:^...::g' | sed 's:.*/::g' | tr '\n' ',' | sed s/,$//g
}
get_git_branch(){
    git branch | grep \* | sed s/^\*\ //g
}
get_change_message(){
    echo "($(get_git_files_changed)):" | vipe | cat
}
get_change_message_without_filename(){
    echo ":" | vipe | cat
}

# Alias for easier git commits
# Commit message wihout any s***
alias gh="git add -u && git commit -m"
alias gv='git add -u && git commit'
# Message with more information with filename
alias gvf='git add -u && git commit -m "$(get_change_message)"'
# Commit message wihout any s*** + push
alias gvp='git add -u && git commit" && git push origin $(get_git_branch)'
# More info + push with filename
alias gvfp='git add -u && git commit -m "$(get_change_message)" && git push origin $(get_git_branch)'
alias gvfp='git add -u && git commit -m "$(get_change_message)" && git push origin $(get_git_branch)'
alias gvfp='git add -u && git commit -m "$(get_change_message)" && git push origin $(get_git_branch)'
# Simple messages
alias gu='git add -u && git commit -m "Updated $(get_git_files_changed)"'
alias gc='git add -u && git commit -m "Clean up $(get_git_files_changed)"'
alias gb='git add -u && git commit -m "Bugfix $(get_git_files_changed)"'
# Simple messge with push
alias gup='git add -u && git commit -m "Updated $(get_git_files_changed)" && git push origin $(get_git_branch)'
alias gcp='git add -u && git commit -m "Clean up $(get_git_files_changed)" && git push origin $(get_git_branch)'
alias gbp='git add -u && git commit -m "Bugfix $(get_git_files_changed)" && git push origin $(get_git_branch)'
# Git add
alias ga='git add'
# Easier push to origin master
alias gp="git push origin $(get_git_branch)"
# Git log and history alias 
alias ggg='git lh|cat'
alias gg='git hm|cat'
alias gggg='git hi|cat'
alias gl='git lg'
# Git diff alias
alias gd='git diff'
# Git status alias
alias gs='git status'
alias g='git status -s'
# Git commit 
alias gcm='git commit'
# Git checkeout
alias gco='git checkout $(git branch | sed s:^..::g | fzf --height 40% --reverse)'
alias gpl='git pull origin $(git branch | sed s:^..::g | fzf --height 40% --reverse)'
alias gpu='git push origin $(git branch | sed s:^..::g | fzf --height 40% --reverse)'
alias gcom='git checkout master'

# More stuff

# prev prev command
get_second_last_command(){
	history | tail -2 | head -1 | sed 's:.*\ .*\ ..\:...::g'
}
alias f='eval $(get_second_last_command)'

# Tmux alias - you will probaby have to kill all the hotfix processes at last
alias tmux="tmux"
alias ta='tmux attach -t'
alias tn='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

#eeeks
alias vim="nvim"
#Just because it happens all the time
alias ivm='vim'
alias vm='nvim'
alias vi='nvim'
#Open last vim session
alias viml='nvim -c :SLoad\ zPreviousSession'
alias v='~/bin/nvimopeniffile $(~/bin/checkiffile ~/.vim_mru_files | grep -v ".git" | fzf --height 40% --reverse --preview "coderay {}")'
alias vv='nvim $(~/bin/checkiffile ~/.vim_mru_files | grep -v ".git" | head -n 1)'

# fzf aliases
alias fd='ls -d */ | fzf --reverse --height "40%" --preview "ls {}"'
alias fgd='gl | cat | fzf --preview "echo {} | sed s:.*\*.::g | sed s: .*::g | git diff"'
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
	  --preview "echo {} | sed 's/.*\*.//' | sed 's/ .*//g' | git diff" \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# for z
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --reverse --inline-info +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}

# Note taking
alias k="python ~/bin/terminalnote.py"
alias kk='python ~/bin/terminalnote.py k'

# Eywa start
alias eywa='cd ~/Documents/Projects/eywa && source bin/activate && cd eywa && echo "\033[0;31m Do start chromix server using chromix-server \033[0m" && python manage.py runserver localhost:4500'
alias es='~/bin/tmuxeywa.sh'
alias eywaserver='~/bin/tmuxeywavim.sh'

# Youtube-dl
alias ydp='youtube-dl -o "%(playlist_index)s_%(title)s.%(ext)s"'

# Use hub instead of git
eval "$(hub alias -s)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Function for transfer.sh
transfer() { 
	if [ $# -eq 0 ]; then
		echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
		return 1;
	fi 
	tmpfile=$( mktemp -t transferXXX );
	if tty -s; then
		basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
		curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
	else
		curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
	fi;
	cat $tmpfile;
	rm -f $tmpfile;
} 

alias meain='echo "Yep thats me, something I can help you with?"'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
