Vagrant.configure("2") do |config|

    # create mgmt node
    config.vm.define :mgmt do |mgmt_config|
        mgmt_config.vm.box = "ubuntu/trusty64"
        mgmt_config.vm.hostname = "mgmt"
        mgmt_config.vm.network :private_network, ip: "10.0.15.10"
        mgmt_config.vm.synced_folder "cfg/", "/home/vagrant/cfg"
        mgmt_config.vm.provider "virtualbox" do |vb|
          vb.memory = "512"
          vb.cpus = "1"
        end
        mgmt_config.vm.provision :shell, path: "ansible-install.sh"
    end
  
    # create load balancer
    config.vm.define :lb do |lb_config|
        lb_config.vm.box = "ubuntu/trusty64"
        lb_config.vm.hostname = "lb"
        lb_config.vm.network :private_network, ip: "10.0.15.11"
        lb_config.vm.network "forwarded_port", guest: 80, host: 8080
        lb_config.vm.provider "virtualbox" do |vb|
          vb.memory = "512"
          vb.cpus = "1"
        end
    end
  
    # create some web servers
    # https://docs.vagrantup.com/v2/vagrantfile/tips.html
    (1..4).each do |i|
      config.vm.define "web#{i}" do |node|
          node.vm.box = "ubuntu/trusty64"
          node.vm.hostname = "web#{i}"
          node.vm.network :private_network, ip: "10.0.15.2#{i}"
          node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
          node.vm.provider "virtualbox" do |vb|
            vb.memory = "512"
            vb.cpus = "1"
          end
      end
    end

    (1..4).each do |i|
      config.vm.define "backend#{i}" do |node|
          node.vm.box = "ubuntu/trusty64"
          node.vm.hostname = "backend#{i}"
          node.vm.network :private_network, ip: "10.0.15.3#{i}"
          node.vm.network "forwarded_port", guest: 5000, host: "500#{i}"
          node.vm.provider "virtualbox" do |vb|
            vb.memory = "512"
            vb.cpus = "1"
          end
      end
    end

    # create database 
    config.vm.define :db do |db_config|
      db_config.vm.box = "ubuntu/trusty64"
      db_config.vm.hostname = "db"
      db_config.vm.network :private_network, ip: "10.0.15.12"
      db_config.vm.network "forwarded_port", guest: 3306, host: 3306
      db_config.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.cpus = "1"
      end
  end  
end
  