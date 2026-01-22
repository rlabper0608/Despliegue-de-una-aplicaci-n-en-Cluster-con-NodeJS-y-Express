Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.hostname = "debian"
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", path: "bootstrap.sh"
end