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
alias rm='rm -i'
alias rm='mv -i ~/Trash'
alias rm='set -f; rmrm'

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
