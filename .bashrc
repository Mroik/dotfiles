#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

PATH=$PATH:~/.local/bin
export _JAVA_AWT_WM_NONREPARENTING=1

alias ocaml='rlwrap ocaml'
alias twelf='rlwrap twelf'
