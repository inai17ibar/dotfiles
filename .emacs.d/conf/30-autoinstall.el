;; AutoInstall
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/auto-install/")
  ;;(auto-install-update-emacswiki-package-name t) ;;高速化のため
  (auto-install-compatibility-setup))
