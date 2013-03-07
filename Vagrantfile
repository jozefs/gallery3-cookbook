require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.host_name = "gallery3-dev"
  config.vm.box = "Debian-6.0.6-amd64-netinst"
  config.vm.box_url = "https://dl.dropbox.com/u/366736/Vagrant%20boxes/debian64.box"
  config.vm.customize ["modifyvm", :id, "--memory", 1024]

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.33.30"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => '',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass',
        :bind_address => '0.0.0.0'
      }
    }

    chef.run_list = [
      "recipe[gallery3::default]"
    ]

    # Uncomment the following line to output Chef debug information
    # chef.log_level = :debug
  end
end
