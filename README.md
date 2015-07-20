# PHPCI VM by Vagrant

## Install

1. Install [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) first.

2. Clone the repository:

 ```bash
 git clone https://github.com/jaceju/vagrant-phpci.git
 ```

3. Build vm:

 ```
 cd vagrant-phpci
 vagrant up
 ```

4. Add IP/hostname mapping to `/etc/hosts` on Host OS:

 ```
 192.168.10.20  phpci.local
 ```

 And the url will be:

 ```
 https://phpic.local
 ```

## Build base box

1. Login to vm:

 ```
 vagrant ssh
 ```

2. Clean cache and history:

 ```
 sudo apt-get clean
 sudo dd if=/dev/zero of=/EMPTY bs=1M
 sudo rm -f /EMPTY
 cat /dev/null > ~/.bash_history && history -c && exit
 ```

3. Package base box:

 ```
 vagrant package --out vagrant-phpci.box
 vagrant box add vagrant-phpci vagrant-phpci.box
 ```

## MySQL accout

* username: `phpci`
* password: `secret`

## PHPCI account

* username: `admin@example.com`
* password: `secret`

## License

MIT
