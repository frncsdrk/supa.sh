#!/usr/bin/env bash
#
# main

build_script() {
  SCRIPT="# supa ${VERSION}"
  # ensure non interactive mode
  SCRIPT+="export DEBIAN_FRONTEND=noninteractive"

  if [ -z "${REBOOT}" ] || [ ! -z "${LIST}" ]; then
    if [ -z "${REBOOT_REQUIRED}" ] || [ ! -z "${LIST}" ]; then
      SCRIPT+=$'\nsudo apt update'
      if [ -z "${LIST_OFF}" ]; then
        SCRIPT+=$'\napt list --upgradeable'
      fi
    fi
  fi
  if [ ! -z "${UPGRADE}" ]; then
    if [ ! -z "${UPGRADE_PACKAGE}" ]; then
      SCRIPT+=$'\nsudo apt install -q --only-upgrade '
      SCRIPT+="${UPGRADE_PACKAGE}"
    else
      SCRIPT+=$'\nsudo apt -q upgrade -y'
    fi
  fi
  if [ ! -z "${AUTOREMOVE}" ]; then
    SCRIPT+=$'\nsudo apt autoremove -y'
  fi
  if [ ! -z "${REBOOT}" ] || [ ! -z "${REBOOT_REQUIRED}" ]; then
    SCRIPT+=$'\nif [ -f "/var/run/reboot-required" ]; then'
    if [ ! -z "${REBOOT_REQUIRED}" ]; then
      SCRIPT+=$'\n  printf \'\n%s\n\' "###########################"'
      SCRIPT+=$'\n  printf \'%s\n\'   "# machine reboot required #"'
      SCRIPT+=$'\n  printf \'%s\n\n\'   "###########################"'
    fi
    if [ ! -z "${REBOOT}" ]; then
      SCRIPT+=$'\n  printf \'%s\n\n\'   "rebooting..."'
      SCRIPT+=$'\n  sudo shutdown -r'
    fi
    SCRIPT+=$'\nfi'
  fi
}

main() {
  get_args "$@"
  build_script
  generate_machines_list

  if [ ! -z "${DEBUG}" ]; then
    printf '%s\n' "${SCRIPT}"
  fi

  for machine in $machines
  do
    printf '\n%s\n' '###'
    printf '%s\n' "# ${machine}"
    if [ ! -z "${VERBOSE}" ]; then
      printf '%s\n' '##'
      build_cmd "$@"
      printf '%s\n' "# cmd: ${executed_cmd}"
    fi
    printf '%s\n\n' '###'
    if [ ! -z "${IDENTITY}" ]; then
      ssh -i "${IDENTITY}" -o IdentitiesOnly=yes "${machine}" "${SCRIPT}"
    else
      ssh "${machine}" "${SCRIPT}"
    fi
  done
}
