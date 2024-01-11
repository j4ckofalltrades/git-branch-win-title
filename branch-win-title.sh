#!/usr/bin/env bash

# Add the current git branch name to the terminal emulator window title.
#
# MIT License
#
# Copyright (c) 2021 Jordan Duabe
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Determine shell
if [ "${ZSH_VERSION-}" ]; then
  CURR_SHELL="zsh"
elif [ "${BASH_VERSION-}" ]; then
  CURR_SHELL="bash"
fi

# Determine if the current directory is a git repo
__is_git_repo() {
  $(git branch --show-current > /dev/null 2>&1)
  echo "$?"
}

# Build window tite that includes the name of the current branch; defaults to
# `user@host:current_working_directory` if current directory is not a git repo.
__branch_win_title() {
  if [[ "$(__is_git_repo)" -eq 0 ]]; then
    local branch
    local dir

    if [[ -n "$(git remote show)" ]]; then
      dir="$(basename -s .git "$(git remote get-url origin)")"
    else
      dir="${PWD/*\//}"
    fi

    branch="$(git branch --show-current)"
    if [[ -n "$branch" ]]; then
      echo "${dir} - [${branch}]"
    else
      local detached_commit
      detached_commit="$(git show -s --format=%h)"
      echo "${dir} - [detached at ${detached_commit}]"
    fi
  else
    case "${CURR_SHELL}" in   
     "bash")
       echo -ne "${USER}@${HOSTNAME}:${PWD/*\//}"
       ;; 
     "zsh")
       print -Pn "\e]0;%n@%m: %~\a"
     ;;
    esac
  fi  
}

__bash_win_title() {
  PROMPT_COMMAND='echo -ne "\033]0;$(__branch_win_title)\007"'
}

__zsh_win_title() {
  eval 'echo -ne "\033]0;$(__branch_win_title)\007"'
}

__set_win_title() {
  case "${CURR_SHELL}" in
    "bash")
      __bash_win_title
      ;; 
    "zsh")
      autoload -U add-zsh-hook
      add-zsh-hook precmd __zsh_win_title
      ;;
  esac
}

__set_win_title
