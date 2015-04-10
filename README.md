# PHPCI VM by Vagrant

## Install

1. Install [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) first, and build base box by [jaceju/vagrant-lamp](https://github.com/jaceju/vagrant-lamp).

2. Clone the repository:

 ```bash
 git clone https://github.com/jaceju/vagrant-phpci.git
 ```

3. Build vm:

 ```
 cd vagrant-phpci
 vagrant up
 ```

4. Add hostname to `/etc/hosts` in Host OS:

 ```
 192.168.10.20  phpci.local
 ```

## MySQL accout

* username: `phpci`
* password: `secret`

## PHPCI account

* username: `admin@example.com`
* password: `secret`

## SSL

Run:

```bash
ssh /vagrant/assets/enssl.sh
```

## License

MIT

