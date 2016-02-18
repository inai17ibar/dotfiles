
## 環境の導入

参考：http://qiita.com/okamos/items/7f5461814e8ed8916870

###Githubのレポジトリ生成（最初のみ）

dotfilesという名前で新しいレポジトリを作る．

###レポジトリをクローンする（）

```
$ cd ~/
$ git clone git@github.com:username/dotfiles.git
```

###管理対象のファイルを移動する

```
$ cd ~/
$ cd dotfiles
$ mv .vimrc dotfiles
$ mv .vim/colors dotfiles
$ mv .vim/ftdetect dotfiles
$ mv .vim/indent dotfiles
$ mv .bash_profile dotfiles
$ mv .bashrc dotfiles
$ mv .zshrc dotfiles
$ mv .hgrc dotfiles
```

###シンボリックリンクを貼る

```
$ ln -sf ~/dotfiles/.vimrc ~/.vimrc
$ ln -sf ~/dotfiles/colors ~/.vim
$ ln -sf ~/dotfiles/ftdetect ~/.vim
$ ln -sf ~/dotfiles/indent ~/.vim
$ ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
```

