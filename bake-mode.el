;;; bake-mode.el --- Mode for bakes Project.meta files.
;; Copyright 2016 christian.koestlin@gmail.com
;;; Commentary:
;; Simple mode for the bake toolkit. (http://esrlabs.github.io/bake/)
;;; Code:

(require 's)

(defgroup bake-mode nil
  "Mode for bake's Project.meta files."
  :group 'bake-mode)

(defcustom bake-mode/indent 4
  "Number of space for one indent.

Emacs adds spaces/tabs according to your settings."
  :type 'integer
  :tag "Indent"
  :safe t)

(defun bake-indent-function ()
  "Indent a line for a bake file."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let* ((p1 (line-beginning-position))
           (p2 (line-end-position))
           (l (s-trim (buffer-substring-no-properties p1 p2)))
           (end-of-block (string-match "}" l))
           (temporary-indent (car (syntax-ppss)))
           (indent (if end-of-block (1- temporary-indent) temporary-indent)))
      ;;(message (format "syntax-ppss: temporary-indent: %s\nl: %s\nend-of-block: %s\nindent: %s" indent l end-of-block indent))
      (indent-line-to (* bake-mode/indent indent)))))

(define-generic-mode
    'bake-mode
  '("#")
  '("Project"
    "default"
    "Description"
    "RequiredBakeVersion"
    "minimum"
    "maximum"
    "Responsible"
    "Person"
    "email"
    "ExecutableConfig"
    "LibraryConfig"
    "CustomConfig"
    "extends"
    "IncludeDir"
    "inherit"
    "true"
    "false"
    "inject"
    "front"
    "back"
    "Set"
    "value"
    "cmd"
    "env"
    "Dependency"
    "config"
    "ExternalLibrary"
    "search"
    "UserLibrary"
    "ExternalLibrarySearchPath"
    "PreSteps"
    "Makefile"
    "lib"
    "target"
    "pathTo"
    "filter"
    "validExitCodes"
    "Flags"
    "CommandLine"
    "on"
    "off"
    "filter"
    "PostSteps"
    "StartupSteps"
    "ExitSteps"
    "DefaultToolchain"
    "outputDir"
    "eclipseOrder"
    "Compiler"
    "ASM"
    "CPP"
    "C"
    "command"
    "Define"
    "Archiver"
    "Linker"
    "LibPrefixFlags"
    "LibPostfixFlags"
    "LintPolicy"
    "Docu"
    "Prebuild"
    "Except"
    "Files"
    "ExcludeFiles"
    "ArtifactName"
    "LinkerScript"
    "MapFile"
  '(("=" . 'font-lock-operator)
    ("+" . 'font-lock-operator)
    (";" . 'font-lock-builtin)
    ("add" . 'font-lock-constant-face)
    ("remove" . 'font-lock-constant-face)
    ("[A-Za-z0-9]*" . 'font-lock-variable-name-face)
    )
  '("Project.meta")
  (list
   (lambda() (set (make-local-variable 'indent-line-function) #'bake-indent-function))
   )
  "A mode for bake's Project.meta files"
  )

(provide 'bake-mode)
;;; bake-mode.el ends here
