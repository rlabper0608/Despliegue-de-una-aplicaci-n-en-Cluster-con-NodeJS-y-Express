Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 4
    vb.memory = "2048"
  end
  config.vm.box = "debian/bookworm64"
  config.vm.hostname = "debian"
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.synced_folder ".", "/vagrant"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.provision "shell", path: "bootstrap.sh"
end