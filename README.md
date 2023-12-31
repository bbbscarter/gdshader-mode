# GDShader emacs major mode

Extension to [glsl-mode](https://github.com/jimhourihan/glsl-mode) that adds font-locking for Godot 4.1's extensions to
GLSL.

See [Godot's shader reference documentation](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/index.html) for details.

## Usage

Clone this repository in your emacs path and use:
```el
(require 'gdshader-mode)
```

Or, if using `use-package` and `straight`
```el
(use-package gdshader-mode 
  :straight (gdshader-mode :type git :host github :repo "bbbscarter/gdshader-mode"))
```

To enable company-mode keyword completion, gdshader-mode provides a list of
keywords through `gdshader-all-keywords`. This can be used like so:

```el
(use-package gdshader-mode
  :straight (gdshader-mode :type git :host github :repo "bbbscarter/gdshader-mode")

  ;; Optional customisations for company-mode completion.
  :init
  (defun gdshader-config()
    (interactive)
    (setq-local company-dabbrev-downcase nil)
    (setq-local company-backends
                '((company-keywords company-dabbrev))))

  :hook (gdshader-mode . gdshader-config)
  :config
  (add-to-list 'company-keywords-alist (append '(gdshader-mode) gdshader-all-keywords)))
```
