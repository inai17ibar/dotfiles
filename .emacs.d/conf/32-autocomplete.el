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

  ;; C-n/C-p で候補を選択
  (define-key ac-complete-mode-map "¥C-n" 'ac-next)
  (define-key ac-complete-mode-map "¥C-p" 'ac-previous)
