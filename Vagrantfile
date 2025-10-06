Vagrant.configure("2") do |config|
  config.vm.define "platform-infra-test" do |machine|
    machine.vm.box = "debian/bookworm64"

    machine.vm.network "private_network", ip: "192.168.57.10"
    machine.vm.hostname = "192-168-57-10"

    machine.vm.provider "virtualbox" do |vb|
      vb.name = "platform-infra-test"
      vb.gui = false
      vb.memory = "2048"
      vb.cpus = 2
    end
  end
  
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yaml"
    ansible.compatibility_mode = "2.0"
  end
end
