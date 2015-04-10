# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.define "phpci" do |phpci|
    phpci.vm.box = "ubunutu-14.04-lamp"
    phpci.vm.provision :shell, :path => "./assets/init.sh"
    phpci.vm.network "forwarded_port", guest: 80, host: 8888
    phpci.vm.network "private_network", ip: "192.168.10.20"
  end

end