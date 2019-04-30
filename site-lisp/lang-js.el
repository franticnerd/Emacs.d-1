(use-package js2-mode
  :ensure t
  :commands js2-mode
  :hook (js2-mode . lsp)
  :init
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

  :config
  (setq js2-basic-offset 2)
  (unbind-key "M-." js2-mode-map))

  ;; (general-define-key :keymaps 'js2-mode-map
  ;;                     "M-." 'lsp-find-definition))

  ;; (add-hook 'js2-mode-hook
  ;;           (lambda () (add-hook 'before-save-hook 'lsp-format-buffer nil t))))

(use-package prettier-js
  :ensure t
  :commands prettier-js-mode prettier-js
  :diminish (prettier-js-mode . "⚚")
  :init
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'css-mode-hook 'prettier-js-mode)
  (add-hook 'scss-mode-hook 'prettier-js-mode)
  :config
  (setq prettier-js-command "prettier-eslint"))

;; (use-package tide
;;   :ensure t
;;   :commands (tide-mode tide-setup tide-hl-identifier-mode)
;;   :after (js2-mode company flycheck)
;;   :hook ((js2-mode . tide-setup)
;;          (js2-mode . tide-hl-identifier-mode)))

(defun jsx-file-p ()
  (and buffer-file-name
       (or (equal (file-name-extension buffer-file-name) "js")
           (equal (file-name-extension buffer-file-name) "jsx"))
       (re-search-forward "\\(^\\s-*import React\\|\\( from \\|require(\\)[\"']react\\)"
                          magic-mode-regexp-match-limit t)))


(use-package rjsx-mode
  :ensure t
  :init
  (add-to-list 'magic-mode-alist (cons #'jsx-file-p 'rjsx-mode))

  (general-define-key :keymaps 'rjsx-mode-map
                      "M-." 'lsp-find-definition))

(use-package  import-js
  :ensure t
  :init
  (add-hook 'rjsx-mode 'run-import-js))

(use-package json-mode
  :ensure t)


(provide 'lang-js)
