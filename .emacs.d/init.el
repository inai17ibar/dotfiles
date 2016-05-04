;;(setq gc-cons-threshold (* 128 1024 1024))

;;;package取得先追加
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
; Initialize
(package-initialize)

;;el-get
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
        (eval-print-last-sexp)))

;;(defalias 'yas/get-snippet-tables 'yas--get-snippet-tables)
;;(defalias 'yas/table-hash 'yas--table-hash)

;;起動のパフォーマンス確認
(require 'esup)
(require 'initchart)
(initchart-record-execution-time-of load file)
(initchart-record-execution-time-of require feature)

;;高速化(scroll-bar-mode 0)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
    (run-with-idle-timer 0.2 nil #'linum-update-current))
(blink-cursor-mode 1)

;;; ユーザー情報
(setq user-full-name "Soichiro Inatani")
(setq user-mail-address "inai17ibar@gmail.com")

;;; クリップボードの共有
(setq x-select-enable-clipboard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3.2 Emacsの起動と終了                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; P30 デバッグモードでの起動
;; おまじない
(require 'cl)
;; Emacsからの質問をy/nで回答する
(fset 'yes-or-no-p 'y-or-n-p)

;;スタートアップメッセージを非表示
;;(setq inhibit-startup-screen t)
;;(setq inhibit-startup-message nil)
(setq inhibit-scratch-message nil)

;;オート保存無効
(setq auto-save-default nil)
(setq make-backup-files nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; キーバインド
;; コピーという名前はない. killing?
;(define-key global-map (kbd "C-c c") 'copy)

;;(define-key global-map (kbd "C-h") 'delete-backward-char) ; 削除
;;(define-key global-map (kbd "M-?") 'help-for-help)        ; ヘルプ
(define-key global-map (kbd "C-t") 'indent-region)      ; インデント
(define-key global-map (kbd "C-c C-i") 'hippie-expand)    ; 補完
(define-key global-map (kbd "C-z") 'undo)                 ; undo
(define-key global-map (kbd "C-c ;") 'comment-dwim)       ; コメントアウト
;;(define-key global-map (kbd "C-o") 'toggle-input-method)  ; 日本語入力切替
(define-key global-map (kbd "M-C-g") 'grep)               ; grep
(define-key global-map (kbd "C-[ M-C-g") 'goto-line)      ; 指定行へ移動

(define-key global-map (kbd "C-o") 'other-window)

; M-x, M-p で 5行移動できるように設定
(define-key global-map (kbd "M-n") (kbd "C-u 5 C-n"))
(define-key global-map (kbd "M-p") (kbd "C-u 5 C-p"))

;; M-<up> <down>が聞かないのはなぜ

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 画像ファイルを表示
;;(auto-image-file-mode t)

;;スペルチェック
(setq-default flyspell-mode t)
(setq ispell-dictionary "american")

;;reload
(global-set-key
  [f12] 'eval-buffer)

;;;if you use add-to-load-path, don't need it
;;;(add-to-list 'load-path' "~/.emacs.d/elisp")
;;for Emacs23
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))
;;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
     (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
         (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
             (normal-top-level-add-subdirs-to-load-path))))))

;;ディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4.2 環境に応じた設定の分岐                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P65 CUIとGUIによる分岐
;; ターミナル以外はツールバー、スクロールバーを非表示
(when window-system
  ;; tool-barを非表示
  (tool-bar-mode 0)
  ;; scroll-barを非表示
  (scroll-bar-mode 0))
;; CocoaEmacs以外はメニューバーを非表示
(unless (eq window-system 'ns)
  ;; menu-barを非表示
    (menu-bar-mode 0))

;;TAB-width:4
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;対応するカッコを強調表示
(show-paren-mode t)
;;Row number
(line-number-mode 1)
(column-number-mode 1)

;;ファイル内のカーソル位置を保存する
(setq-default save-place t)
;; 予約語を色分けする
(global-font-lock-mode t)
;;Design
(load-theme 'misterioso t)
(if window-system (progn
    ;;(set-background-color "Black")
    ;;(set-foreground-color "LightGray")
    ;;(set-cursor-color "Gray")
    (set-frame-parameter nil 'alpha 40) ;透明度
    ))

;; C-k １回で行全体を削除する
(setq kill-whole-line t)
;; active でない window の空 cursor を出さない
(setq cursor-in-non-selected-windows nil)
;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5.3 環境変数の設定                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P82-83 パスの設定
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/bin")
;; 日本語IM用の設定
(setq default-input-method "MacOSX")
;; 日本語の設定（UTF-8）
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
;;; P86 ファイル名の扱い
;; Mac OS Xの場合のファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
;; Windowsの場合のファイル名の設定
;;(when (eq window-system 'w32)
;;  (set-file-name-coding-system 'cp932)
;;  (setq locale-coding-system 'cp932))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5.4 フレームに関する設定                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P87-89 モードラインに関する設定
;; カラム番号も表示
(column-number-mode t)
;; ファイルサイズを表示
(size-indication-mode t)
;; 時計を表示（好みに応じてフォーマットを変更可能）
(setq display-time-day-and-date t) ; 曜日・月・日を表示
(setq display-time-24hr-format t) ; 24時表示
(display-time-mode t)
;; バッテリー残量を表示
;;(display-battery-mode t)
;; リージョン内の行数と文字数をモードラインに表示する（範囲指定時のみ）
;; http://d.hatena.ne.jp/sonota88/20110224/1298557375
(defun count-lines-and-chars ()
  (if mark-active
	  (format "%d lines,%d chars "
			  (count-lines (region-beginning) (region-end))
			  (- (region-end) (region-beginning)))
	;; これだとエコーエリアがチラつく
	;;(count-lines-region (region-beginning) (region-end))
	""))

(add-to-list 'default-mode-line-format
			 '(:eval (count-lines-and-chars)))

;;; P90 タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")
;; 行番号を常に表示する
(global-linum-mode t)

;; '¥' を入力したら '\' となるように
(define-key global-map [?¥] [?\\])
;;; Localeに合わせた環境の設定
(put 'upcase-region 'disabled nil)

;; AutoInstall
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/auto-install/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))

;; (install-elisp "http://www.emacswiki.org/emacs/download/redo+.el")
(when (require 'redo+ nil t)
  ;; C-' にリドゥを割り当てる
  (global-set-key (kbd "C-'") 'redo)
  ;; 日本語キーボードの場合C-. などがよいかも
  ;; (global-set-key (kbd "C-.") 'redo)
    ) ; ←ここでC-x C-eで設定反映

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6.2 統一したインタフェースでの操作                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P122-129 候補選択型インタフェース──Anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間。デフォルトは0.5
   anything-idle-delay 0.2
   ;; タイプして再描写するまでの時間。デフォルトは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数。デフォルトは50
   anything-candidate-number-limit 100
   ;; 候補が多いときに体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
	;; root権限でアクションを実行するときのコマンド
	;; デフォルトは"su"
	(setq anything-su-or-sudo "sudo"))
  (require 'anything-match-plugin nil t)
  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(require 'anything-migemo nil t))
  (when (require 'anything-complete nil t)
	;; lispシンボルの補完候補の再検索時間
	(anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
	(require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
	;; describe-bindingsをAnythingに置き換える
	(descbinds-anything-install)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6.3 入力の効率化                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P130-131 利用可能にする
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
			   "~/.emacs.d/elpa/auto-complete-20150408.1132/dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

(when (require 'auto-complete-clang nil t)
  (add-to-list 'ac-dictionary-directories
	           "~/.emacs.d/elpa/auto-complete-clang-20140409.52/dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6.4 検索と置換の拡張                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P132 検索結果をリストアップする──color-moccur
;; color-moccurの設定
(when (require 'color-moccur nil t)
  ;; M-oにoccur-by-moccurを割り当て
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでAND検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索のとき除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  ;; Migemoを利用できる環境であればMigemoを使う
  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(setq moccur-use-migemo t)))

;; ▼要拡張機能インストール▼
;;; P133-134 moccurの結果を直接編集──moccur-edit
;; moccur-editの設定
(require 'moccur-edit nil t)
;; moccur-edit-finish-editと同時にファイルを保存する
;; (defadvice moccur-edit-change-file
;;   (after save-after-moccur-edit-buffer activate)
;;   (save-buffer))

;; ▼要拡張機能インストール▼
;;; P136 grepの結果を直接編集──wgrep
;; wgrepの設定
;;;(require 'wgrep nil t)

;; for python
(add-hook 'python-mode-hook
		  (lambda ()
						(define-key python-mode-map (kbd "\C-m") 'newline-and-indent)
			            (define-key python-mode-map (kbd "RET") 'newline-and-indent)))


;; for space and tab
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
						 trailing       ; 行末
						 tabs           ; タブ
						 spaces         ; スペース
						 empty          ; 先頭/末尾の空行
						 space-mark     ; 表示のマッピング
						 tab-mark
						 ))

(setq whitespace-display-mappings
	  '((space-mark ?\u3000 [?\u25a1])
		;; WARNING: the mapping below has a problem.
		;; When a TAB occupies exactly one column, it will display the
		;; character ?\xBB at that column followed by a TAB which goes to
		;; the next TAB column.
		;; If this is a problem for you, please, comment the line below.
		(tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
					:background my/bg-color
					:foreground "DeepPink"
					:underline t)
(set-face-attribute 'whitespace-tab nil
					:background my/bg-color
					:foreground "LightSkyBlue"
					:underline t)
(set-face-attribute 'whitespace-space nil
					:background my/bg-color
					:foreground "GreenYellow"
					:weight 'bold)
(set-face-attribute 'whitespace-empty nil
					                    :background my/bg-color)

;;高速化(背景の透過で遅くなる) iTermでもできる
;;(set-frame-parameter nil 'alpha 100)
