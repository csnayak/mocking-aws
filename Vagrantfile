require 'yaml'

# Load settings from the YAML file
settings = YAML.load_file(File.join(File.dirname(__FILE__), 'settings.yaml'))

Vagrant.configure("2") do |config|

  # Global synced folder setting
  settings['shared_folders'].each do |folder|
    config.vm.synced_folder folder['host_path'], folder['vm_path'], owner: "vagrant", group: "vagrant"
  end

  # Iterate over the nodes specified in settings
  settings['nodes']['specifications'].each do |node|
    config.vm.define node['name'] do |machine|
      machine.vm.box = settings['software']['box']
      machine.vm.hostname = node['name']

      # Configure host-only network
      # machine.vm.network "private_network", type: 'dhcp'

      # Disable NAT interface
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{settings['cluster_name']}_#{node['name']}"
        vb.cpus = node['cpu']
        vb.memory = node['memory']

        # Disable NAT interface
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      end

      # Check if node['scripts'] is defined and not nil
      if node['scripts']
        # Run the provisioning scripts, if any
        node['scripts'].each do |script|
          script_path = File.join(File.dirname(__FILE__), script)
          if File.exist?(script_path)
            machine.vm.provision "shell", path: script_path
          else
            puts "Provisioning script #{script} does not exist."
          end
        end
      end
    end
  end
end