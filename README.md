## automatic archlinux installation (system: UEFI / Intel / 64bit / Nvidia GPU )

- create `boot` and `root` partitions with `cfdisk` (~1G for `boot`, rest for `root`)
- get internet access with `iwctl` (or ethernet)
- `pacman -Sy`
- `pacman -S git`
- `git clone https://github.com/cbernard10/archinstall`
- `cp archinstall/archinstall.sh .`
- `sh archinstall.sh`

- execute `bspwm-install.sh` in the home directory of the user created by the previous script
