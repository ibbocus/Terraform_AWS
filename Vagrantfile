# Install required plugins
required_plugins = ["vagrant-hostsupdater", "vagrant-berkshelf"]
required_plugins.each do |plugin|
  unless Vagrant.has_plugin?(plugin)
    # User vagrant plugin manager to install plugin, which will automatically refresh plugin list afterwards
    puts "Installing vagrant plugin #{plugin}"
    Vagrant::Plugin::Manager.instance.install_plugin plugin
    puts "Installed vagrant plugin #{plugin}"
  end
end



def set_env vars
  command = <<~HEREDOC
      echo "Setting Environment Variables"
      source ~/.bashrc
  HEREDOC

  vars.each do |key, value|
    command += <<~HEREDOC
      if [ -z "$#{key}" ]; then
          echo "export #{key}=#{value}" >> ~/.bashrc
      fi
    HEREDOC
  end

  return command
end

Vagrant.configure("2") do |config|
  config.vm.define "aws" do |aws|
    aws.vm.box = "ubuntu/xenial64"
    aws.vm.network "private_network", ip: "192.168.33.12"
    aws.hostsupdater.aliases = ["development.local"]
    aws.vm.synced_folder "app/", "/home/vagrant/app"
    aws.vm.synced_folder "playbooks/", "/home/vagrant/playbooks"
    aws.vm.synced_folder "terraform/", "/home/vagrant/terraform"
    aws.vm.synced_folder "key/", "/home/vagrant/key/"
    aws.vm.provision "shell", path: "terraform/run_terraform.sh", privileged: false
    aws.vm.provision "shell", inline: set_env({ AWS_ACCESS_KEY: $AWS_ACCESS_KEY_ID }), privileged: false
    aws.vm.provision "shell", inline: set_env({ AWS_SECRET_KEY: $AWS_SECRET_KEY }), privileged: false

  end

end
