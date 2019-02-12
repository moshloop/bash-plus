#!/bin/bash
## START_OF_BASH_PLUS
red="\033[38;5;196m"
neutral='\033[0m'
cyan='\033[00;34m'
white='\033[97m'
green="\033[38;5;46m"
ok=${green}"✔"${neutral}
# fail=${red}"✖"${neutral}


epoch () {
  echo `python -c "import time; print  ('{:0.0f}'.format(time.time()))"`
}

stopwatch () {
  BEGIN=$1
  NOW=`epoch`
  let DIFF=$(( $NOW - $BEGIN ))
  echo $DIFF
}

info () {
  >&2 printf " [ ${cyan}INFO${neutral} ] $1 $2\n"
}

user () {
  # shellcheck disable=SC2059
 >&2 printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  >&2 printf "   [ ${green}OK${neutral} ] $1 $2\n"
}

fatal () {
  error $2
  exit 1
}

error(){
 >&2  printf "[ ${red}ERROR${neutral} ] $1 $2\n"
}

# log a message with a seconds since program start prefix
log() {
  if [[ "$START" == "" ]]; then
      START=$(epoch)
  fi
  >&2 printf "[ $(printf %05d $(stopwatch $START)) ] $1\n"
}


die(){
    printf ${red}"$1${neutral} "$2"\n"
    exit 1
}

hr(){
  >&2   echo "================================================================================"
}

hr2(){
  >&2   echo "=================================================="
}

hr3(){
  >&2   echo "========================================"
}

strict_mode() {

  set -o errexit
  set -o nounset
  set -o pipefail
}

strict_mode_off() {
  unset -o errexit
  unset -o nounset
  unset -o pipefail
}

is_linux(){
    if [ "$(uname -s)" = "Linux" ]; then
        return 0
    else
        return 1
    fi
}

is_mac(){
    if [ "$(uname -s)" = "Darwin" ]; then
        return 0
    else
        return 1
    fi
}

is_jenkins(){
    if [ -n "${JENKINS_URL:-}" ]; then
        return 0
    else
        return 1
    fi
}

is_travis(){
    if [ -n "${TRAVIS:-}" ]; then
        return 0
    else
        return 1
    fi
}

is_CI(){
    if [ -n "${CI:-}" -o -n "${CI_NAME:-}" ] || is_jenkins || is_travis; then
        return 0
    else
        return 1
    fi
}
timestamp=$(date +%s)
## END_OF_BASH_PLUS
