#.bash_profile はログイン時にのみ実行されます。具体的な用途は:
#  環境変数を設定する (export する変数)
#環境変数はプロセス間で勝手に受け継がれるのでログイン時のみ設定すれば十分です。

#
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/include
export PATH=/usr/local/bin:/usr/local/include:$PATH
#export PATH=$PATH:/usr/include/c++/4.2.1

#PYTHONPATH ライブラリの場所を指定する
#pyenvを入れた時は無闇に追加しない
#export PYTHONPATH=/Library/Python/2.7/site-packages #標準
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH #brew?
#export PYTHONOATH=/usr/local/lib/python3.4/site-packages:$PYTHONPATH
export PYTHONPATH=/Users/inai17ibar/workspace/research/lstm/rnnlib_source_forge_version/utils
#NOTE:brewでpython,pipはいれない


#バージョンのインストール先
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"

## cuda(hands install)
## MBAはCUDAがないので
##export PATH=/Developer/NVIDIA/CUDA-7.5/bin:$PATH
##export PATH=/usr/local/cuda/bin:$PATH
##export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-7.5/lib:$DYLD_LIBRARY_PATH
##export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH
##eval "$(rbenv init -)"
eval "$(rbenv init -)"
