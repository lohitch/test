# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
   config.vm.boot_timeout=600
   config.vm.box = "ubuntu/trusty64"
   config.vm.network :private_network, ip: "10.0.15.25"
   config.vm.network :forwarded_port, guest: 80, host: 1010 


   config.ssh.forward_agent = true
   config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

   config.vm.define :'splunk' do |d|

    d.vm.hostname = 'splunk'
    d.vm.synced_folder '.', '/vagrant', id: 'vagrant-root', disabled: true

    

    d.vm.provider :virtualbox do |v|
      v.customize 'pre-boot', ['modifyvm', :id, '--nictype1', 'virtio']
      v.customize [ 'modifyvm', :id, '--name', 'splunk_server', '--memory', '1024', '--cpus', '1' ]
    end

  end
  
  config.vm.provision :chef_solo do |chef| 
     chef.cookbooks_path = "cookbooks"
     chef.roles_path = "roles"
     chef.add_role("splunk_server")
  end
end
