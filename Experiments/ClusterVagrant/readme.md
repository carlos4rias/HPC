# Vagrant Cluster

## Requirements 

In order to set and run the mpic, openmp cluster you will need to have the following requirements : 

*  Virtualbox5.2 
*  Vagrant and all his dependencies

## Running 

```sh
user@machine:$ git clone https://github.com/carlos4rias/HPC
user@machine:$ cd HPC/Experiments/ClusterVagrant
user@machine:$ vagrant up
```

the number of worker node can be changed in the **VagrantFile** changing the following section of the code :

```ruby 

(2..5).each do |i|
    
    config.vm.define "worker-#{i}" do |node|
      node.vm.box = "ubuntu/bionic64"
      node.vm.hostname = "node-#{i}"
      node.vm.network :private_network, ip: "10.11.12.#{i}"

      node.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = "230"
      end  
      
    end

  end
  
```

in case that you want more worker nodes, you could change _5_ by your number of nodes.


## Provision Script

If you want to incorporated new bash scripts or repetive task  I'd recommed  to make the changes in the `provision.sh` file.
