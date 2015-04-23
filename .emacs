(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(gdb-show-main nil)
 '(inhibit-startup-screen t)
 '(matlab-shell-command-switches (quote ("-nodesktop -nosplash"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;need for muse-el and python-mode deb packages

(set-default-font "DejaVu Sans Mono-10")
(set-fontset-font "fontset-default"
'han '("WenQuanYi Micro Hei Mono" . "unicode-bmp"))
(set-fontset-font "fontset-default"
'cjk-misc '("WenQuanYi Micro Hei Mono" . "unicode-bmp"))
(set-fontset-font "fontset-default"
'bopomofo '("WenQuanYi Micro Hei Mono" . "unicode-bmp"))
(set-fontset-font "fontset-default"
'gb18030 '("WenQuanYi Micro Hei Mono". "unicode-bmp"))
(set-fontset-font "fontset-default"
'symbol '("WenQuanYi Micro Hei Mono". "unicode-bmp"))
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10"))
;;设置字体

(setq default-frame-alist 
'((top . 40) (left . 400) 
(width . 170) (height . 60) 
))
;;设置窗口大小

(setq user-full-name "X.J. Zhang")
(setq user-mail-address "mfs6174@gmail.com")
;;用户信息

(global-font-lock-mode t);语法高亮
(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no，可能你觉得不需要，呵呵。
(show-paren-mode t);显示括号匹配
(display-time-mode 1);显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(tool-bar-mode 0);去掉那个大大的工具栏
(scroll-bar-mode 0);去掉滚动条，因为可以使用鼠标滚轮了 ^_^
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。很好玩阿，这个功能
(transient-mark-mode t);这个忘了，郁闷！
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
(setq frame-title-format "mfs6174@%b");在标题栏提示你目前在什么位置。你要把zhan改成自己的用户名
(global-linum-mode t);;设置显示行号

(add-to-list 'load-path "~/.emacsd")
;;加载目录

(add-hook 'shell-mode-hook 'wcy-shell-mode-hook-func)
(defun wcy-shell-mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                            #'wcy-shell-mode-kill-buffer-on-exit)
      )
(defun wcy-shell-mode-kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))
;;使shell能够自动退出

(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'GBK 'gbk)

(autoload 'markdown-mode "markdown-mode"
	"Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'". markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'". markdown-mode))
;;开启markdown模式

;;所以我们不再使用muse模式
;; (require 'muse-mode)
;; ;; Load publishing style
;; (require 'muse-html)
;; (require 'muse-wiki)
;; (require 'muse-latex)
;; (require 'muse-texinfo)
;; (require 'muse-docbook)

;;开启cedet的semantic自动补全
(require 'cedet)
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode
				  ;;global-semantic-idle-completions-mode
				  global-semantic-decoration-mode
				  global-semantic-highlight-func-mode))
(semantic-mode 1)
(global-semantic-highlight-edits-mode (if window-system 1 -1))
(global-semantic-show-unmatched-syntax-mode 1)
(global-semantic-show-parser-state-mode 1)

;; (setq semanticdb-project-roots (list (expand-file-name "/")))
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public"
	"." "./include" "./inc" "./common" "./public"
        "../.." "../../include" "../../inc" "../../common" "../../public"))
(defconst cedet-win32-include-dirs
  (list "C:/MinGW/include"
        "C:/MinGW/include/c++/3.4.5"
        "C:/MinGW/include/c++/3.4.5/mingw32"
        "C:/MinGW/include/c++/3.4.5/backward"
        "C:/MinGW/lib/gcc/mingw32/3.4.5/include"
        "C:/Program Files/Microsoft Visual Studio/VC98/MFC/Include"))
(require 'semantic-c nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (when (eq system-type 'windows-nt)
    (setq include-dirs (append include-dirs cedet-win32-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))


(require 'ido)
(ido-mode t)
;;打开文件的辅助功能

(defun mfs-sudo-find-file (sfile)
(interactive "sFile ")
  (find-file (concat "/sudo:localhost:" sfile)))
(global-set-key (kbd "C-c f") 'mfs-sudo-find-file)
;;open with sudo

;(require 'tabbar)
;(tabbar-mode t)
;;开启标签栏功能 不常用 注释掉加快速度


;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-kingsajz)
(load-file "~/.emacsd/mycolor1.el")
(my-color-theme)
;;设置颜色主题

;;开启glsl
(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))

;(global-set-key [(f5)] 'loop-alpha)  ;;注意这行中的F8 , 可以改成你想要的按键1 
;(setq alpha-list '((60 45) (100 100)))
;(defun loop-alpha ()
 ; (interactive)
 ; (let ((h (car alpha-list)))                
  ;  ((lambda (a ab)
   ;    (set-frame-parameter (selected-frame) 'alpha (list a ab))
    ;   (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
    ;   ) (car h) (car (cdr h)))
    ;(setq alpha-list (cdr (append alpha-list (list h))))
    ;)
;)
;;这个在debian sid with gnome3 中似乎已经没有作用 注释掉 以后再研究


(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacsd/dict")
(ac-config-default)
;;开启自动完成


(load-file "~/.emacsd/multi-gdb-ui.el")
(require 'gud)
(global-set-key [(C-f8)] 'gud-gdb)
;;开启gdb

(global-set-key (kbd "C-k") 'kill-whole-line)
(global-set-key (kbd "M-j") 'backward-char)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "M-k") 'next-line)
(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "C-S-k") 'kill-line)
;;个性键位


(require 'cc-mode)

(defun gdb-hori ()
	(interactive)
	(delete-other-windows)
	(split-window-horizontally)
	(other-window 1)
	(ido-switch-buffer)
	(beginning-of-buffer)
	(next-line 20)
	(recenter-top-bottom)
	(other-window 1)
)
(global-set-key [(f8)] 'gdb-hori)
;;原创的左右gdb模式 自定义函数


(defun my-c-comment ()                                                                                     
 (interactive)                                                                                        
 (insert "/* */")                                                                       
 (backward-char 3)
)
(global-unset-key "\M-;")     
(global-set-key "\M-;" 'my-c-comment)
(defun jumozhushi ()
  (interactive)
  (move-end-of-line 1)
  (insert "//")
)
;;(global-unset-key "\C-/")
(global-set-key (kbd "C-/") 'jumozhushi)
;;快速添加注释块 自定义函数


(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.emacsd/templates/") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query 0) ;;; If you don't want to be prompted before insertion

(setq auto-insert-alist
      (append '(
            (c++-mode . "usaco.cpp")
            )
           auto-insert-alist))


(setq auto-insert-alist
      (append '(
            (asm-mode . "asm-temp.asm")
            )
           auto-insert-alist))

(setq auto-insert-alist
      (append '(
		(python-mode . "coding.py")
		)
           auto-insert-alist))


;;自动插入 自定义函数


(defun moban (sname)
  (interactive "sName ")
  (insert-file (concat auto-insert-directory sname))
)
(global-set-key (kbd "C-c i") 'moban)
;;自动插入模版 自定义函数


(add-to-list 'load-path "~/.emacsd/matlab-emacs")
(require 'matlab-load)
(require 'cedet-matlab)
(matlab-cedet-setup)
(add-hook 'matlab-mode-hook
          (lambda ()
            (auto-complete-mode 1)
	    (c-toggle-hungry-state 1)
            ))

(add-hook 'matlab-mode-hook 'auto-complete-mode)
(setq auto-mode-alist
      (cons
       '("\\.m$" . matlab-mode)
       auto-mode-alist))
;;matlab模式

;;twit插件 平时不用所以注释掉加快速度
;(load-file "/home/mfs6174/.emacsd/twit.elc")
;(require 'twit)
;  (setq twit-show-user-images t) ;; 显示好友头像
;  (setq twit-user-image-dir "~/.twit") ;; 设置头像保存路径
;(global-set-key (kbd "C-c t") 'twit-show-recent-tweets)
;(global-set-key (kbd "C-c w") 'twit-post)


;;一键快速编译 C++-mode 自定义函数
(defun quick-compile ()
"A quick compile funciton for C++"
(interactive)
(compile (concat "g++ -g  -O0 -Wall -o " (buffer-name (current-buffer)) ".out  " (buffer-name (current-buffer)) ));;-coverage
(other-window 1)
)
(global-set-key [(C-f9)] 'quick-compile)  ;;快捷键C-F9

(setq opencv_debian "g++ -g  -Wall `pkg-config --libs --cflags opencv` -lopencv_nonfree -o ")
(setq opencv_local  "g++ -Wl,-rpath,/usr/local/lib/ -g  -Wall -I/usr/local/include/ /usr/local/lib/libopencv_calib3d.so  /usr/local/lib/libopencv_contrib.so  /usr/local/lib/libopencv_core.so  /usr/local/lib/libopencv_features2d.so  /usr/local/lib/libopencv_flann.so  /usr/local/lib/libopencv_gpu.so  /usr/local/lib/libopencv_highgui.so  /usr/local/lib/libopencv_imgproc.so  /usr/local/lib/libopencv_legacy.so  /usr/local/lib/libopencv_ml.so  /usr/local/lib/libopencv_objdetect.so  /usr/local/lib/libopencv_ocl.so  /usr/local/lib/libopencv_photo.so  /usr/local/lib/libopencv_stitching.so  /usr/local/lib/libopencv_superres.so    /usr/local/lib/libopencv_video.so /usr/local/lib/libopencv_videostab.so  -o ")
(defun quick-compile-opencv ()
"A quick compile funciton for codes with OpenCV"
(interactive)
(compile (concat opencv_local  (buffer-name (current-buffer)) ".out  " (buffer-name (current-buffer)) ));;-coverage
;;(compile (concat "g++ -g  -Wall `pkg-config --libs --cflags opencv` -o " (buffer-name (current-buffer)) ".out  " (buffer-name (current-buffer)) ))
(other-window 1)
)
(global-set-key [(C-S-f9)] 'quick-compile-opencv)

(defun quick-compile-opengl ()
"A quick compile funciton for codes with OpenGL(glew and glfw)"
(interactive)
(compile (concat "g++ -g  -Wall `pkg-config --libs --cflags glfw3 glew` -o " (buffer-name (current-buffer)) ".out  " (buffer-name (current-buffer)) ));;-coverage
(other-window 1)
)
(global-set-key [(C-S-f10)] 'quick-compile-opengl)


(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(setq c-default-style "GNU")
;;风格设置
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)
;;set c program style
(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  ;;; hungry-delete and auto-newline
  ;;(c-toggle-auto-newline)
  (c-toggle-hungry-state 1)
  (interactive)
  (setq c-basic-offset 2)
  (imenu-add-menubar-index)
  (which-function-mode)
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")

  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-hook 'LaTeX-mode-hook (lambda()
			     (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
			     (setq TeX-command-default "XeLaTeX")
			     (setq TeX-save-query  nil )
			     (setq TeX-show-compilation t)
			     ))

(defun mtex-template ()
  (interactive)
  (erase-buffer)
  (insert-file (concat auto-insert-directory "template.tex"))
  (beginning-of-buffer)
  (next-line 256)
)
(global-set-key (kbd "C-c t") 'mtex-template)

