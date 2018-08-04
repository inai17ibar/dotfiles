#なるべくbashの設定を使う
#source ~/.bashrc #bashprofileからも読んでいる
source ~/.bash_profile

#PATHの設定はbashprofileで

########################################
# 環境変数
export LANG=ja_JP.UTF-8
export LC_ALL='ja_JP.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'
export JAVA_HOME=$(/usr/libexec/java_home)

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
PATH=${PATH}:~/bin
#補完リストが多いときに尋ねない
LISTMAX=1000
#ヒストリの一覧を読みやすい形に変更
HISTTIMEFORMAT="[%Y/%M/%D %H:%M:%S] "

# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -u

# 色を使用出来るようにする
autoload -Uz colors
colors

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
LANG=en_US.UTF-8 vcs_info
RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# beep を無効にする
setopt no_beep
# フローコントロールを無効にする
setopt no_flow_control
# '#' 以降をコメントとして扱う
setopt interactive_comments
# ディレクトリ名だけでcdする
setopt auto_cd
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

## Keybind vim|emacs
bindkey -v
#bindkey -e

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

#入力途中の履歴補完を有効化する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#入力途中の履歴補完
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#インクリメンタルサーチの設定
#bindkey "^R" history-incremental-search-backward
#bindkey "^S" history-incremental-search-forward

#履歴のインクリメンタル検索でワイルドカード利用可能
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# コピペ
if which pbcopy >/dev/null 2>&1 ; then
# Mac
alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
# Linux
alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
# Cygwin
alias -g C='| putclip'
fi


########################################
# エイリアス for コマンドライン補完

# ↑を設定すると、 .. とだけ入力したら1つ上のディレクトリに移動できるので……
# 2つ上、3つ上にも移動できるようにする
alias ...='cd ../..'
alias ....='cd ../../..'

set rmstar #*を使うときの確認
alias rm='rmtrash' #brewに入れているrmtrashを使う
alias ls='ls -CF'
alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias sc='screen'
#alias ps='ps --sort=start_time'
alias mkdir='mkdir -p'

alias awka="awk 'NR==1'"                   # 最初の行を表示する
alias awke="awk 'END{print}'"              # 最後の行を表示する
alias awkd="awk 'NF'"                      # 空行を削除する
alias awkl="awk 'END{print NR}'"           # 行数をカウントする

alias sortuni='sort | uniq -c | sort -nr'  # データの出現語をランキング

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
# Mac
alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
# Linux
alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
# Cygwin
alias -g C='| putclip'
fi

alias vimpr='vim ~/.profile'
alias vimba='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias vimlo='vim ~/.bash_logout'
alias vimsc='vim ~/.screenrc'
alias vimma='vim $MAIL'
alias soba='source ~/.bashrc'
alias sobap='source ~/.bash_profile'
alias sozs='source ~/.zshrc'

#エイリアス for プログラム呼び出し
alias atom='/usr/local/bin/atom'
alias emacs='/usr/local/bin/emacs' ##GNU Emacs 24.5.1
alias subl='/Applications//Sublime\ Text\ 3.app/Contents/SharedSupport/bin/subl'
#alias brew="env PATH=${PATH/\/Users\/inai17ibar\/\.phpenv\/shims:/} brew"
alias vscode='open -a /Applications/Visual\ Studio\ Code.app'

########################################
# OS 別の設定
case ${OSTYPE} in
darwin*)
#Mac用の設定
export CLICOLOR=1
alias ls='ls -G -F'
;;
linux*)
#Linux用の設定
alias ls='ls -F --color=auto'
;;
esac

#######################################
### Oh my zsh setting
plugins=(brew git ruby gem pip)

function peco-select-history() {
local tac
if which tac > /dev/null; then
tac="tac"
else
tac="tail -r"
fi
BUFFER=$(\history -n 1 | \
eval $tac | \
peco --query "$LBUFFER")
CURSOR=$#BUFFER
zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


##############################################
#PATH="$PATH:$HOME/.cask/bin"

#export PATH="$PATH:$HOME/.anyenv/bin"
#eval "$(anyenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/inai17ibar/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/inai17ibar/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/inai17ibar/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/inai17ibar/google-cloud-sdk/completion.zsh.inc'; fi
