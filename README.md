# icons-in-terminal-ibuffer

[![License](http://img.shields.io/:license-gpl3-blue.svg)](LICENSE)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [icons-in-terminal-ibuffer](#icons-in-terminal-ibuffer)
    - [Screenshot](#screenshot)
    - [Pre-requisites](#pre-requisites)
    - [Install](#install)
    - [Original](#original)
    - [Wish List](#wish-list)

<!-- markdown-toc end -->

Display icons for all buffers in ibuffer.

This only works for Emacs **in terminal** (emacs -nw).
If you use Emacs GUI you should refer to <a
href="https://github.com/seagle0128/all-the-icons-ibuffer">*all-the-icons-ibuffer*</a>

## Screenshot
![icons-in-terminal-ibuffer](https://user-images.githubusercontent.com/236042/80401294-0c20d780-88f7-11ea-9863-87b4b2ea2162.png)

cf) The line at the very bottom is not part of Emacs. It is *tmux* status bar 😉

## Pre-requisites

1. A font from  <a href="https://github.com/sebastiencs/icons-in-terminal">icons-in-terminal</a> which unifies many useful fonts. Follow the instruction found there.
2. An <a href="https://github.com/seagle0128/icons-in-terminal.el">icons-in-terminal.el</a> package.
  Put the elisp files in a directory where load-path locates

## Install

Put the elisp files of this project into a directory where load-path indicates. And add few lines of elisp code to your init.el


```emacs-lisp
(require 'icons-in-terminal-ibuffer)
(add-hook 'ibuffer-mode-hook (lambda ()
    (if (display-graphic-p)
        (all-the-icons-ibuffer-mode)
        (icons-in-terminal-ibuffer-mode))))
```

This code assumes that you use all-the-icons-ibuffer-mode for Emacs GUI.

Enjoy! 😀


## Original
This repository is inspired by <a
href="https://github.com/seagle0128/all-the-icons-ibuffer">all-the-icons-ibuffer</a>. It shows pretty icons in Emacs GUI 👍


## Wish List
It is fully inspired by *all-the-icon-ibuffer* but I hope to unify both *icons-in-terminal-ibuffer* and *all-the-icon-ibuffer* packages into one. These two have the same functionality and the same internal structure, so it is very natural to become one. However the biggest obstacle is that *icons-in-terminal-ibuffer* lacks portability so it is hard to expect that it works everywhere.
So for now, I made it as a forked project.
