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

## MySQL accout

* username: `phpci`
* password: `secret`

## PHPCI account

* username: `admin@example.com`
* password: `secret`

## License

MIT
