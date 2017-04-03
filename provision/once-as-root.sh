#!/usr/bin/env bash

#== Import script args ==

timezone=$(echo "$1")
user_name=$(echo "$2")
user_password=$(echo "$3")

#== Bash helpers ==

function info {
  echo " "
  echo "--> $1"
  echo " "
}

#== Provision script ==

info "Provision-script user: `whoami`"

export DEBIAN_FRONTEND=noninteractive

info "Configure timezone"
timedatectl set-timezone ${timezone} --no-ask-password

info "Add root user"
useradd -m ${user_name} -p `perl -e "print crypt("${user_password}","Q4")"` -s /bin/bash
usermod -a -G sudo ${user_name}

info "Done"