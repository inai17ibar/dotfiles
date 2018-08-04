#.bashrc は対話モードの bash を起動する時に毎回実行されます。具体的な用途は:
#  環境変数でない変数を設定する (export しない変数)
#  エイリアスを定義する
#  シェル関数を定義する
#  コマンドライン補完の設定をする
#これらは bash を起動する度に毎回設定する必要があるものです。

#zshrcをメインで使うのでこちらはコンパクトにする．
set bell-style none

#二回宣言される
# 環境変数を設定
#export PATH=$PATH:/sbin:/usr/sbin # パス
#export PAGER='/usr/bin/lv -c' # man とかで使われる
#export EDITOR='/usr/bin/vim' # visudo とかで使われる

