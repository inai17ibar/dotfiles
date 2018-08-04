;;対応するカッコを強調表示
(setq show-paren-dilay 0)
(show-paren-mode t)

;;Row number
(line-number-mode 1)
(column-number-mode 1)

;; シンタックスハイライトの設定
(defface my-hl-line-face
  ;; 背景がdarkならば背景色を紺に
  '((((class color) (background dark))
	 (:backgrounnd "NavyBlue" t))
	;; 背景色がlightならば背景色を緑に
	(((class color) (background light))
	 (:background "LightFoldenrodYellow"))
	(t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

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
