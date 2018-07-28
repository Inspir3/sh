#!/bin/sh

log_FORMAT="%Y/%m/%d %H:%M:%S"
log_FILE="/var/log/foo.log"
log_OFF=0
log_ERREUR=1
log_WARN=2
log_INFO=3
log_DEBUG=4
log_PREFIX=""
log_NIVEAU=$log_INFO

if [ ! -e $log_FILE ]; then
  sudo touch $log_FILE
  sudo chmod 666 $log_FILE
fi

#---------------------
#
#---------------------
log_trace(){
  local niv=$1
  local txt="$2"
  local output=""

  if [ $niv -gt $log_NIVEAU ]; then 
    return 0
  fi

  output=`date +"$log_FORMAT"`

  if [ "$log_PREFIX" != "" ]; then
    output="$output [$log_PREFIX]"
  fi

  case $niv in
    $log_ERREUR) output="$output [ERREUR] $txt";;
    $log_WARN)   output="$output   [WARN] $txt";;
    $log_INFO)   output="$output   [INFO] $txt";;
    $log_DEBUG)  output="$output  [DEBUG] $txt";;
  esac

  printf "%s\n" "$output" | tee -a $log_FILE
}

log_erreur(){
  log_trace $log_ERREUR "$1"
}

log_warn(){
  log_trace $log_WARN "$1"
}

log_info(){
  log_trace $log_INFO "$1"
}

log_debug(){
  log_trace $log_DEBUG "$1"
}
