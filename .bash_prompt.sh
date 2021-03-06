#!/bin/bash
#
# DESCRIPTION:
#
#   Set the bash prompt according to:
#    * the branch/status of the current git repository
#    * the revision of the current subversion repository
#    * the return value of the previous command
# 
# USAGE:
#
#   1. Save this file as ~/.git_svn_bash_prompt.sh
#   2. Add the following line to the end of your ~/.profile or ~/.bash_profile:
#        . ~/.git_svn_bash_prompt
#
# AUTHOR:
# 
#   Scott Woods <scott@westarete.com>
#   West Arete Computing
#
#   Based on work by halbtuerke and lakiolen.
#
#   http://gist.github.com/31967
#
#   Forked & Enhanced by mnpk<mnncat@gmail.com>
 
 
# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
     PURPLE="\[\033[0;35m\]"
       CYAN="\[\033[0;36m\]"
      WHITE="\[\033[0;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"
 
# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}
 
# Detect whether the current directory is a subversion repository.
# function is_svn_repository {
#   test -d .svn
# }
 
# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"
 
  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${PURPLE}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${RED}"
  fi
  
  # Set arrow icon based on status against remote.
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi
  
  # Get the name of the branch.
  branch_pattern="^(# )?On branch ([^${IFS}]*)"    
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[2]}
  fi
 
  # Set the final branch string.
  BRANCH="${state}(${branch})${remote}${COLOR_NONE} "
}
 
# Determine the branch information for this subversion repository. No support
# for svn status, since that needs to hit the remote repository.
# function set_svn_branch {
#   # Capture the output of the "git status" command.
#   svn_status="$(svn status | egrep '^M' 2> /dev/null)"
#  
#   # Set color based on clean/staged/dirty.
#   if [[ ${svn_status} = "" ]]; then
#     state="${PURPLE}"
#   else
#     state="${RED}"
#   fi
# 
#   # Capture the output of the "git status" command.
#   svn_info="$(svn info | egrep '^Revision|^리비전' 2> /dev/null)"
#   revision=''
#  
#   # Get the name of the branch.
#   revision_pattern="^Revision: (.*)"
#   revision_pattern_kor="^리비전: (.*)"
#   if [[ ${svn_info} =~ $revision_pattern ]]; then
#     revision=${BASH_REMATCH[1]}
#   elif [[ ${svn_info} =~ $revision_pattern_kor ]]; then
#     revision=${BASH_REMATCH[1]}
#   fi
#  
#   # Set the final revision string.
#   BRANCH="${state}(r${revision})${COLOR_NONE} "
# }
 
# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="\$"
  else
      PROMPT_SYMBOL="${RED}\$${COLOR_NONE}"
  fi
}

function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}
 
# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the 
  # return value of the last command.
  set_prompt_symbol $?
 
  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  # elif is_svn_repository ; then
  #   set_svn_branch
  else
    BRANCH=''
  fi

  set_virtualenv
  
  # Set the bash prompt variable.
  PS1="$PYTHON_VIRTUALENV$RED\u$COLOR_NONE@$YELLOW\h$COLOR_NONE:$CYAN\w $COLOR_NONE${BRANCH}${PROMPT_SYMBOL} "
}
 
# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
