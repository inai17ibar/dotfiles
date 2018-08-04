;;el-get
(require 'setup-el-get)
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
        (eval-print-last-sexp)))

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

;;; クリップボードの共有
(setq x-select-enable-clipboard t)

;; ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)
;; beep音を消す
(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;;スペルチェック
(setq-default flyspell-mode t)
(setq ispell-dictionary "american")

;;reload
(global-set-key
  [f12] 'eval-buffer)

;; Emacsからの質問をy/nで回答する
(fset 'yes-or-no-p 'y-or-n-p)

;;オート保存無効
(setq auto-save-default nil)
(setq make-backup-files nil)
;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; active でない window の空 cursor を出さない
(setq cursor-in-non-selected-windows nil)
;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; '¥' を入力したら '\' となるように
(define-key global-map [?¥] [?\\])
;;; Localeに合わせた環境の設定
(put 'upcase-region 'disabled nil)

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))
(global-whitespace-mode 1)

;;高速化(背景の透過で遅くなる) iTermでもできる
;;(set-frame-parameter nil 'alpha 100)

;; Macのキーバインドを使う
;;(mac-key-mode 1)

;; Macのoptionをメタキーにする
(setq mac-option-modifier 'meta)
