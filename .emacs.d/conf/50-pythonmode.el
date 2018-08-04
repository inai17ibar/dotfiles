;; for python
(add-hook 'python-mode-hook
		  (lambda ()
						(define-key python-mode-map (kbd "\C-m") 'newline-and-indent)
			            (define-key python-mode-map (kbd "RET") 'newline-and-indent)))
