#.bash_profile はログイン時にのみ実行されます。具体的な用途は:
#  環境変数を設定する (export する変数)
#環境変数はプロセス間で勝手に受け継がれるのでログイン時のみ設定すれば十分です。
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export PATH=/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/include
export PATH=$PATH:/usr/local/include
export PATH=$PATH:/usr/include/c++/4.2.1
#export PATH=$PATH:$HOME/.rvm/bin
#export PATH=/usr/texbin:$PATH #mac-tex

#rails
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && \. "$HOME/.rvm/scripts/rvm"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


#PYTHONPATH ライブラリの場所を指定する
#pyenvを入れた時は無闇に追加しない
#export PYTHONPATH=/Library/Python/2.7/site-packages #標準
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH #brew?
#export PYTHONOATH=/usr/local/lib/python3.4/site-packages:$PYTHONPATH
export PYTHONPATH=/Users/inai17ibar/workspace/research/lstm/rnnlib_source_forge_version/utils
#NOTE:brewでpython,pipはいれない

export HISTSIZE=100000 #history
export LANG='ja_JP.UTF-8'
export LC_ALL='ja_JP.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'


export JAVA_HOME=$(/usr/libexec/java_home)


#バージョンのインストール先
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"
export VIRTUAL_ENV_DISABLE_PROMPT=1
eval export PATH="/Users/inai17ibar/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh
source '/usr/local/Cellar/pyenv/20151006/libexec/../completions/pyenv.zsh'
pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "`pyenv "sh-$command" "$@"`";;
  *)
    command pyenv "$command" "$@";;
  esac
}

## cuda(hands install)
export PATH=/Developer/NVIDIA/CUDA-7.5/bin:$PATH
export PATH=/usr/local/cuda/bin:$PATH
export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-7.5/lib:$DYLD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH
eval "$(rbenv init -)"
