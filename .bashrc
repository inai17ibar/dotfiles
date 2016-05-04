
#.bashrc は対話モードの bash を起動する時に毎回実行されます。具体的な用途は:
#  環境変数でない変数を設定する (export しない変数)
#  エイリアスを定義する
#  シェル関数を定義する
#  コマンドライン補完の設定をする
#これらは bash を起動する度に毎回設定する必要があるものです。

set bell-style none

#環境変数でない変数

#コマンドライン補完

#エイリアス
alias emacs='/usr/local/bin/emacs' ##GNU Emacs 24.5.1
alias subl='/Applications//Sublime\ Text\ 3.app/Contents/SharedSupport/bin/subl'
#alias cot='open -a Coteditor'

export EDITOR="/usr/local/bin/mate -w"

set rmstar
alias rm='rmtrash'
alias mv='mv -i'
alias cp='cp -ip'

alias ls='ls -CF'
alias ll='ls -AlFh --show-control-chars --color=auto'
alias la='ls -CFal'
alias sc='screen'
#alias ps='ps --sort=start_time'

#alias rm='mv -i ~/Trash'
#alias rm='set -f; rmrm'

alias awka="awk 'NR==1'"                   # 最初の行を表示する
alias awke="awk 'END{print}'"              # 最後の行を表示する
alias awkd="awk 'NF'"                      # 空行を削除する
alias awkl="awk 'END{print NR}'"           # 行数をカウントする

alias sortuni='sort | uniq -c | sort -nr'  # データの出現語をランキング

alias vimpr='vim ~/.profile'
alias vimba='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias vimlo='vim ~/.bash_logout'
alias vimsc='vim ~/.screenrc'
alias vimma='vim $MAIL'
alias soba='source ~/.bashrc'

# プロンプトの表示をカスタマイズ
export PS1='\[\033[01;32m\]\u@\H\[\033[01;34m\] \w \$\[\033[00m\]'

# もろもろ環境変数を設定
export PATH=$PATH:/sbin:/usr/sbin # パス
export PAGER='/usr/bin/lv -c' # man とかで使われる
export EDITOR='/usr/bin/vim' # visudo とかで使われる
export HISTSIZE=100000 # これだけコマンド履歴を残す
export LANG='ja_JP.UTF-8' # 以下 3 つ文字コード
export LC_ALL='ja_JP.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'

#シェル関数
function rmrm() {
	local ch
	echo $@ | grep -Gq "^/$\| /$\|^/ \| / "
	if [ $? -eq 0 ]; then
		set +f
		echo "DONOT execute 'rm /'"
		return 1
	fi

	echo $@ | grep -q "*"
	if [ $? -eq 0 ]; then
		set +f
		ls $@
		if [ $? -ne 0 ]; then
			return 0
		fi
		echo -n "Are you sure? [Y/n] "
		while : ; do
			read ch
			if [ "${ch}" = "Y" ]; then
				command rm $@
				return 0
			elif [ "${ch}" = "n" ] || [ "${ch}" = "N" ]; then
				return 1
			else
				echo -n "[Y/n]"
			fi
		done
	else
		command rm $@
		return 0
	fi
}
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
