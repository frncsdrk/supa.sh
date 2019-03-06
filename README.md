# supa.sh

**S**erver **Up**date with **A**pt

> bash tool to update debian-based linux machines, also means soup in Greek

## usage

```
supa

Usage:
  ./supa.sh <user>@<host> [-h|--help] [-v|--version] [-l|--list] [--list-off]
  [-i|--identity <identity file>] [-u|--upgrade <package>] [-a|--autoremove] [-m|--machines]
  [-b|--reboot-required] [-r|--reboot] [-d|--debug]

Options:
  -a|--autoremove
          autoremove

  -b|--reboot-required
          reboot required

  -d|--debug
          enable debug mode

  -h|--help
          show this message

  -i|--identity
          identity

  -l|--list
          list

  --list-off
          list off, only update

  -m|--machines
          use given machines file

  -r|--reboot
          reboot

  -u|--upgrade
          upgrade

  -v|--version
          version

Examples:
  supa.sh -v
          display version

  supa.sh -h
          display this message

  supa.sh you@remote-host -b
          is machine reboot required

  supa.sh you@remote-host -b -l
          is machine reboot required, but list upgradeable packages as well

  supa.sh -m production -b -l
          same as previous but use machines file

  supa.sh you@remote-host
          run apt update and apt list --upgradeable

  supa.sh you@remote-host -u
          same as the former but with the addition of upgrading all packages

  supa.sh you@remote-host -u <package>
          same as the former but with the addition of upgrading one single package

  supa.sh you@remote-host -u -r
          same as the former but with the addition of allowing reboot if necessary

  supa.sh you@remote-host -u -a -r
          same as the former but with the addition of autoremoving of obsolete packages

```

### machines file

```sh
# my awesome host
me@remote-host
# my second awesome host
me@remote-host2
```

## installation

Run `./setup.sh` (may require `sudo`)

## license

[MIT](https://github.com/frncsdrk/supa/blob/master/LICENSE) (c) frncsdrk 2019
