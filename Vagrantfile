Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Enable Berkshelf to manage this cookbook's dependencies.
  config.berkshelf.enabled = true;

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.hostname = "gallery3-dev"

  config.vm.box = "Debian-6.0.6-amd64-netinst"
  config.vm.box_url = "https://dl.dropbox.com/u/366736/Vagrant%20boxes/debian64.box"
  config.vm.customize ["modifyvm", :id, "--memory", 1024]

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "192.168.33.30"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.

  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an the Gallery3 folder to the VM. We assume that it is at the same
  # level in the directory hierarchy as the base directory of this repository.
  #
  # In the future, we should gracefully handle the case when this directory
  # is missing.
  config.vm.synced_folder "../gallery3", "/gallery3", :nfs => true

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end

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
