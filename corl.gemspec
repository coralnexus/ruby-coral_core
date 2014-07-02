# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "corl"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adrian Webb"]
  s.date = "2014-07-02"
  s.description = "Framework that provides a simple foundation for growing organically in the cloud"
  s.email = "adrian.webb@coralnexus.com"
  s.executables = ["corl"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".gitmodules",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/corl",
    "bootstrap/bootstrap.sh",
    "bootstrap/lib/shell/LICENSE.txt",
    "bootstrap/lib/shell/command.sh",
    "bootstrap/lib/shell/filesystem.sh",
    "bootstrap/lib/shell/load.sh",
    "bootstrap/lib/shell/os.sh",
    "bootstrap/lib/shell/script.sh",
    "bootstrap/lib/shell/starter.sh",
    "bootstrap/lib/shell/validators.sh",
    "bootstrap/os/ubuntu/00_base.sh",
    "bootstrap/os/ubuntu/01_git.sh",
    "bootstrap/os/ubuntu/02-editor.sh",
    "bootstrap/os/ubuntu/05_ruby.sh",
    "bootstrap/os/ubuntu/06_puppet.sh",
    "bootstrap/os/ubuntu/09_nucleon.sh",
    "bootstrap/os/ubuntu/10_corl.sh",
    "corl.gemspec",
    "lib/CORL/builder/identity.rb",
    "lib/CORL/builder/package.rb",
    "lib/CORL/configuration/file.rb",
    "lib/CORL/machine/AWS.rb",
    "lib/CORL/machine/physical.rb",
    "lib/CORL/machine/rackspace.rb",
    "lib/CORL/machine/vagrant.rb",
    "lib/CORL/network/CORL.rb",
    "lib/CORL/node/AWS.rb",
    "lib/CORL/node/local.rb",
    "lib/CORL/node/rackspace.rb",
    "lib/CORL/node/vagrant.rb",
    "lib/CORL/provisioner/puppetnode.rb",
    "lib/core/build.rb",
    "lib/core/errors.rb",
    "lib/core/facade.rb",
    "lib/core/mixin/action/keypair.rb",
    "lib/core/mixin/action/registration.rb",
    "lib/core/mixin/builder.rb",
    "lib/core/mixin/lookup.rb",
    "lib/core/mixin/machine/ssh.rb",
    "lib/core/mixin/macro/network_settings.rb",
    "lib/core/mod/fog_aws_server.rb",
    "lib/core/mod/fog_rackspace_server.rb",
    "lib/core/mod/hiera_backend.rb",
    "lib/core/plugin/builder.rb",
    "lib/core/plugin/cloud_action.rb",
    "lib/core/plugin/configuration.rb",
    "lib/core/plugin/fog_machine.rb",
    "lib/core/plugin/fog_node.rb",
    "lib/core/plugin/machine.rb",
    "lib/core/plugin/network.rb",
    "lib/core/plugin/node.rb",
    "lib/core/plugin/provisioner.rb",
    "lib/core/util/puppet.rb",
    "lib/core/util/puppet/resource.rb",
    "lib/core/util/puppet/resource_group.rb",
    "lib/core/vagrant/Vagrantfile",
    "lib/core/vagrant/action.rb",
    "lib/core/vagrant/actions/delete_cache.rb",
    "lib/core/vagrant/actions/init_keys.rb",
    "lib/core/vagrant/actions/link_network.rb",
    "lib/core/vagrant/commands/launcher.rb",
    "lib/core/vagrant/config.rb",
    "lib/core/vagrant/plugins.rb",
    "lib/core/vagrant/provisioner/config.rb",
    "lib/core/vagrant/provisioner/provisioner.rb",
    "lib/corl.rb",
    "lib/facter/corl_build.rb",
    "lib/facter/corl_config_ready.rb",
    "lib/facter/corl_network.rb",
    "lib/facter/custom_facts.rb",
    "lib/facter/vagrant_exists.rb",
    "lib/hiera/corl_logger.rb",
    "lib/nucleon/action/cloud/create.rb",
    "lib/nucleon/action/cloud/hiera.rb",
    "lib/nucleon/action/cloud/images.rb",
    "lib/nucleon/action/cloud/inspect.rb",
    "lib/nucleon/action/cloud/machines.rb",
    "lib/nucleon/action/cloud/regions.rb",
    "lib/nucleon/action/cloud/vagrantfile.rb",
    "lib/nucleon/action/node/IP.rb",
    "lib/nucleon/action/node/SSH.rb",
    "lib/nucleon/action/node/authorize.rb",
    "lib/nucleon/action/node/bootstrap.rb",
    "lib/nucleon/action/node/build.rb",
    "lib/nucleon/action/node/destroy.rb",
    "lib/nucleon/action/node/exec.rb",
    "lib/nucleon/action/node/facts.rb",
    "lib/nucleon/action/node/identity.rb",
    "lib/nucleon/action/node/image.rb",
    "lib/nucleon/action/node/keypair.rb",
    "lib/nucleon/action/node/lookup.rb",
    "lib/nucleon/action/node/provision.rb",
    "lib/nucleon/action/node/reboot.rb",
    "lib/nucleon/action/node/revoke.rb",
    "lib/nucleon/action/node/seed.rb",
    "lib/nucleon/action/node/spawn.rb",
    "lib/nucleon/action/node/start.rb",
    "lib/nucleon/action/node/stop.rb",
    "lib/nucleon/event/puppet.rb",
    "lib/nucleon/template/environment.rb",
    "lib/puppet/indirector/corl.rb",
    "lib/puppet/indirector/data_binding/corl.rb",
    "lib/puppet/parser/functions/corl_include.rb",
    "lib/puppet/parser/functions/corl_initialize.rb",
    "lib/puppet/parser/functions/corl_merge.rb",
    "lib/puppet/parser/functions/corl_resources.rb",
    "lib/puppet/parser/functions/ensure.rb",
    "lib/puppet/parser/functions/file_exists.rb",
    "lib/puppet/parser/functions/global_array.rb",
    "lib/puppet/parser/functions/global_hash.rb",
    "lib/puppet/parser/functions/global_options.rb",
    "lib/puppet/parser/functions/global_param.rb",
    "lib/puppet/parser/functions/interpolate.rb",
    "lib/puppet/parser/functions/is_false.rb",
    "lib/puppet/parser/functions/is_true.rb",
    "lib/puppet/parser/functions/module_array.rb",
    "lib/puppet/parser/functions/module_hash.rb",
    "lib/puppet/parser/functions/module_options.rb",
    "lib/puppet/parser/functions/module_param.rb",
    "lib/puppet/parser/functions/name.rb",
    "lib/puppet/parser/functions/render.rb",
    "lib/puppet/parser/functions/value.rb",
    "locales/en.yml",
    "rdoc/site/0.4.29/CORL.html",
    "rdoc/site/0.4.29/CORL/Action.html",
    "rdoc/site/0.4.29/CORL/Action/Authorize.html",
    "rdoc/site/0.4.29/CORL/Action/Bootstrap.html",
    "rdoc/site/0.4.29/CORL/Action/Build.html",
    "rdoc/site/0.4.29/CORL/Action/Destroy.html",
    "rdoc/site/0.4.29/CORL/Action/Exec.html",
    "rdoc/site/0.4.29/CORL/Action/Facts.html",
    "rdoc/site/0.4.29/CORL/Action/Image.html",
    "rdoc/site/0.4.29/CORL/Action/Images.html",
    "rdoc/site/0.4.29/CORL/Action/Ip.html",
    "rdoc/site/0.4.29/CORL/Action/Keypair.html",
    "rdoc/site/0.4.29/CORL/Action/Lookup.html",
    "rdoc/site/0.4.29/CORL/Action/Machines.html",
    "rdoc/site/0.4.29/CORL/Action/Provision.html",
    "rdoc/site/0.4.29/CORL/Action/Reboot.html",
    "rdoc/site/0.4.29/CORL/Action/Regions.html",
    "rdoc/site/0.4.29/CORL/Action/Revoke.html",
    "rdoc/site/0.4.29/CORL/Action/Seed.html",
    "rdoc/site/0.4.29/CORL/Action/Spawn.html",
    "rdoc/site/0.4.29/CORL/Action/Ssh.html",
    "rdoc/site/0.4.29/CORL/Action/Start.html",
    "rdoc/site/0.4.29/CORL/Action/Stop.html",
    "rdoc/site/0.4.29/CORL/Action/Vagrantfile.html",
    "rdoc/site/0.4.29/CORL/Configuration.html",
    "rdoc/site/0.4.29/CORL/Configuration/File.html",
    "rdoc/site/0.4.29/CORL/Errors.html",
    "rdoc/site/0.4.29/CORL/Event.html",
    "rdoc/site/0.4.29/CORL/Event/Puppet.html",
    "rdoc/site/0.4.29/CORL/Facade.html",
    "rdoc/site/0.4.29/CORL/Machine.html",
    "rdoc/site/0.4.29/CORL/Machine/Aws.html",
    "rdoc/site/0.4.29/CORL/Machine/Fog.html",
    "rdoc/site/0.4.29/CORL/Machine/Physical.html",
    "rdoc/site/0.4.29/CORL/Machine/Rackspace.html",
    "rdoc/site/0.4.29/CORL/Machine/Vagrant.html",
    "rdoc/site/0.4.29/CORL/Mixin.html",
    "rdoc/site/0.4.29/CORL/Mixin/Action.html",
    "rdoc/site/0.4.29/CORL/Mixin/Action/Keypair.html",
    "rdoc/site/0.4.29/CORL/Mixin/Lookup.html",
    "rdoc/site/0.4.29/CORL/Mixin/Machine.html",
    "rdoc/site/0.4.29/CORL/Mixin/Machine/SSH.html",
    "rdoc/site/0.4.29/CORL/Mixin/Macro.html",
    "rdoc/site/0.4.29/CORL/Mixin/Macro/NetworkSettings.html",
    "rdoc/site/0.4.29/CORL/Network.html",
    "rdoc/site/0.4.29/CORL/Network/Default.html",
    "rdoc/site/0.4.29/CORL/Node.html",
    "rdoc/site/0.4.29/CORL/Node/Aws.html",
    "rdoc/site/0.4.29/CORL/Node/Fog.html",
    "rdoc/site/0.4.29/CORL/Node/Local.html",
    "rdoc/site/0.4.29/CORL/Node/Rackspace.html",
    "rdoc/site/0.4.29/CORL/Node/Vagrant.html",
    "rdoc/site/0.4.29/CORL/Plugin.html",
    "rdoc/site/0.4.29/CORL/Plugin/CloudAction.html",
    "rdoc/site/0.4.29/CORL/Provisioner.html",
    "rdoc/site/0.4.29/CORL/Provisioner/Puppetnode.html",
    "rdoc/site/0.4.29/CORL/Template.html",
    "rdoc/site/0.4.29/CORL/Template/Environment.html",
    "rdoc/site/0.4.29/CORL/Util.html",
    "rdoc/site/0.4.29/CORL/Util/Puppet.html",
    "rdoc/site/0.4.29/CORL/Util/Puppet/Resource.html",
    "rdoc/site/0.4.29/CORL/Util/Puppet/ResourceGroup.html",
    "rdoc/site/0.4.29/CORL/Vagrant.html",
    "rdoc/site/0.4.29/CORL/Vagrant/Config.html",
    "rdoc/site/0.4.29/Facter.html",
    "rdoc/site/0.4.29/Facter/Util.html",
    "rdoc/site/0.4.29/Facter/Util/Loader.html",
    "rdoc/site/0.4.29/Fog.html",
    "rdoc/site/0.4.29/Fog/Compute.html",
    "rdoc/site/0.4.29/Fog/Compute/AWS.html",
    "rdoc/site/0.4.29/Fog/Compute/AWS/Server.html",
    "rdoc/site/0.4.29/Fog/Compute/RackspaceV2.html",
    "rdoc/site/0.4.29/Fog/Compute/RackspaceV2/Server.html",
    "rdoc/site/0.4.29/Hiera.html",
    "rdoc/site/0.4.29/Hiera/Backend.html",
    "rdoc/site/0.4.29/Hiera/Corl_logger.html",
    "rdoc/site/0.4.29/Nucleon.html",
    "rdoc/site/0.4.29/Nucleon/Config.html",
    "rdoc/site/0.4.29/Nucleon/Plugin.html",
    "rdoc/site/0.4.29/Nucleon/Plugin/Base.html",
    "rdoc/site/0.4.29/Nucleon/Plugin/Configuration.html",
    "rdoc/site/0.4.29/Nucleon/Plugin/Machine.html",
    "rdoc/site/0.4.29/Nucleon/Plugin/Network.html",
    "rdoc/site/0.4.29/Nucleon/Plugin/Node.html",
    "rdoc/site/0.4.29/Nucleon/Plugin/Provisioner.html",
    "rdoc/site/0.4.29/Object.html",
    "rdoc/site/0.4.29/Puppet.html",
    "rdoc/site/0.4.29/Puppet/DataBinding.html",
    "rdoc/site/0.4.29/Puppet/DataBinding/Corl.html",
    "rdoc/site/0.4.29/Puppet/Indirector.html",
    "rdoc/site/0.4.29/Puppet/Indirector/Corl.html",
    "rdoc/site/0.4.29/Puppet/Parser.html",
    "rdoc/site/0.4.29/Puppet/Parser/Functions.html",
    "rdoc/site/0.4.29/README_rdoc.html",
    "rdoc/site/0.4.29/Vagrant.html",
    "rdoc/site/0.4.29/Vagrant/Config.html",
    "rdoc/site/0.4.29/Vagrant/Config/Loader.html",
    "rdoc/site/0.4.29/Vagrant/Vagrantfile.html",
    "rdoc/site/0.4.29/VagrantPlugins.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Action.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Action/DeleteCache.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Action/InitKeys.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Action/LinkNetwork.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/BaseAction.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Command.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Command/Launcher.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Config.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Config/CORL.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Plugin.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Provisioner.html",
    "rdoc/site/0.4.29/VagrantPlugins/CORL/Provisioner/CORL.html",
    "rdoc/site/0.4.29/created.rid",
    "rdoc/site/0.4.29/images/add.png",
    "rdoc/site/0.4.29/images/brick.png",
    "rdoc/site/0.4.29/images/brick_link.png",
    "rdoc/site/0.4.29/images/bug.png",
    "rdoc/site/0.4.29/images/bullet_black.png",
    "rdoc/site/0.4.29/images/bullet_toggle_minus.png",
    "rdoc/site/0.4.29/images/bullet_toggle_plus.png",
    "rdoc/site/0.4.29/images/date.png",
    "rdoc/site/0.4.29/images/delete.png",
    "rdoc/site/0.4.29/images/find.png",
    "rdoc/site/0.4.29/images/loadingAnimation.gif",
    "rdoc/site/0.4.29/images/macFFBgHack.png",
    "rdoc/site/0.4.29/images/package.png",
    "rdoc/site/0.4.29/images/page_green.png",
    "rdoc/site/0.4.29/images/page_white_text.png",
    "rdoc/site/0.4.29/images/page_white_width.png",
    "rdoc/site/0.4.29/images/plugin.png",
    "rdoc/site/0.4.29/images/ruby.png",
    "rdoc/site/0.4.29/images/tag_blue.png",
    "rdoc/site/0.4.29/images/tag_green.png",
    "rdoc/site/0.4.29/images/transparent.png",
    "rdoc/site/0.4.29/images/wrench.png",
    "rdoc/site/0.4.29/images/wrench_orange.png",
    "rdoc/site/0.4.29/images/zoom.png",
    "rdoc/site/0.4.29/index.html",
    "rdoc/site/0.4.29/js/darkfish.js",
    "rdoc/site/0.4.29/js/jquery.js",
    "rdoc/site/0.4.29/js/navigation.js",
    "rdoc/site/0.4.29/js/search.js",
    "rdoc/site/0.4.29/js/search_index.js",
    "rdoc/site/0.4.29/js/searcher.js",
    "rdoc/site/0.4.29/rdoc.css",
    "rdoc/site/0.4.29/table_of_contents.html",
    "rdoc/site/0.5.0/CORL.html",
    "rdoc/site/0.5.0/CORL/Build.html",
    "rdoc/site/0.5.0/CORL/Builder.html",
    "rdoc/site/0.5.0/CORL/Builder/Identity.html",
    "rdoc/site/0.5.0/CORL/Builder/Package.html",
    "rdoc/site/0.5.0/CORL/Configuration.html",
    "rdoc/site/0.5.0/CORL/Configuration/File.html",
    "rdoc/site/0.5.0/CORL/Errors.html",
    "rdoc/site/0.5.0/CORL/Facade.html",
    "rdoc/site/0.5.0/CORL/Machine.html",
    "rdoc/site/0.5.0/CORL/Machine/AWS.html",
    "rdoc/site/0.5.0/CORL/Machine/Fog.html",
    "rdoc/site/0.5.0/CORL/Machine/Physical.html",
    "rdoc/site/0.5.0/CORL/Machine/Rackspace.html",
    "rdoc/site/0.5.0/CORL/Machine/Vagrant.html",
    "rdoc/site/0.5.0/CORL/Mixin.html",
    "rdoc/site/0.5.0/CORL/Mixin/Action.html",
    "rdoc/site/0.5.0/CORL/Mixin/Action/Keypair.html",
    "rdoc/site/0.5.0/CORL/Mixin/Builder.html",
    "rdoc/site/0.5.0/CORL/Mixin/Builder/Global.html",
    "rdoc/site/0.5.0/CORL/Mixin/Builder/Instance.html",
    "rdoc/site/0.5.0/CORL/Mixin/Lookup.html",
    "rdoc/site/0.5.0/CORL/Mixin/Machine.html",
    "rdoc/site/0.5.0/CORL/Mixin/Machine/SSH.html",
    "rdoc/site/0.5.0/CORL/Mixin/Macro.html",
    "rdoc/site/0.5.0/CORL/Mixin/Macro/NetworkSettings.html",
    "rdoc/site/0.5.0/CORL/Network.html",
    "rdoc/site/0.5.0/CORL/Network/CORL.html",
    "rdoc/site/0.5.0/CORL/Node.html",
    "rdoc/site/0.5.0/CORL/Node/AWS.html",
    "rdoc/site/0.5.0/CORL/Node/Fog.html",
    "rdoc/site/0.5.0/CORL/Node/Local.html",
    "rdoc/site/0.5.0/CORL/Node/Rackspace.html",
    "rdoc/site/0.5.0/CORL/Node/Vagrant.html",
    "rdoc/site/0.5.0/CORL/Plugin.html",
    "rdoc/site/0.5.0/CORL/Plugin/Builder.html",
    "rdoc/site/0.5.0/CORL/Plugin/Configuration.html",
    "rdoc/site/0.5.0/CORL/Plugin/Machine.html",
    "rdoc/site/0.5.0/CORL/Plugin/Network.html",
    "rdoc/site/0.5.0/CORL/Plugin/Node.html",
    "rdoc/site/0.5.0/CORL/Plugin/Provisioner.html",
    "rdoc/site/0.5.0/CORL/Provisioner.html",
    "rdoc/site/0.5.0/CORL/Provisioner/Puppetnode.html",
    "rdoc/site/0.5.0/CORL/Util.html",
    "rdoc/site/0.5.0/CORL/Util/Puppet.html",
    "rdoc/site/0.5.0/CORL/Util/Puppet/Resource.html",
    "rdoc/site/0.5.0/CORL/Util/Puppet/ResourceGroup.html",
    "rdoc/site/0.5.0/CORL/Vagrant.html",
    "rdoc/site/0.5.0/CORL/Vagrant/Config.html",
    "rdoc/site/0.5.0/Fog.html",
    "rdoc/site/0.5.0/Fog/Compute.html",
    "rdoc/site/0.5.0/Fog/Compute/AWS.html",
    "rdoc/site/0.5.0/Fog/Compute/AWS/Server.html",
    "rdoc/site/0.5.0/Fog/Compute/RackspaceV2.html",
    "rdoc/site/0.5.0/Fog/Compute/RackspaceV2/Server.html",
    "rdoc/site/0.5.0/Hiera.html",
    "rdoc/site/0.5.0/Hiera/Backend.html",
    "rdoc/site/0.5.0/Hiera/Corl_logger.html",
    "rdoc/site/0.5.0/Nucleon.html",
    "rdoc/site/0.5.0/Nucleon/Action.html",
    "rdoc/site/0.5.0/Nucleon/Action/Cloud.html",
    "rdoc/site/0.5.0/Nucleon/Action/Cloud/Create.html",
    "rdoc/site/0.5.0/Nucleon/Action/Cloud/Hiera.html",
    "rdoc/site/0.5.0/Nucleon/Action/Cloud/Images.html",
    "rdoc/site/0.5.0/Nucleon/Action/Cloud/Inspect.html",
    "rdoc/site/0.5.0/Nucleon/Action/Cloud/Machines.html",
    "rdoc/site/0.5.0/Nucleon/Action/Cloud/Regions.html",
    "rdoc/site/0.5.0/Nucleon/Action/Cloud/Vagrantfile.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Authorize.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Bootstrap.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Build.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Destroy.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Exec.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Facts.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/IP.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Image.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Keypair.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Lookup.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Provision.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Reboot.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Revoke.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/SSH.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Seed.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Spawn.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Start.html",
    "rdoc/site/0.5.0/Nucleon/Action/Node/Stop.html",
    "rdoc/site/0.5.0/Nucleon/Config.html",
    "rdoc/site/0.5.0/Nucleon/Event.html",
    "rdoc/site/0.5.0/Nucleon/Event/Puppet.html",
    "rdoc/site/0.5.0/Nucleon/Plugin.html",
    "rdoc/site/0.5.0/Nucleon/Plugin/Base.html",
    "rdoc/site/0.5.0/Nucleon/Plugin/CloudAction.html",
    "rdoc/site/0.5.0/Nucleon/Template.html",
    "rdoc/site/0.5.0/Nucleon/Template/Environment.html",
    "rdoc/site/0.5.0/Object.html",
    "rdoc/site/0.5.0/Puppet.html",
    "rdoc/site/0.5.0/Puppet/DataBinding.html",
    "rdoc/site/0.5.0/Puppet/DataBinding/Corl.html",
    "rdoc/site/0.5.0/Puppet/Indirector.html",
    "rdoc/site/0.5.0/Puppet/Indirector/Corl.html",
    "rdoc/site/0.5.0/Puppet/Parser.html",
    "rdoc/site/0.5.0/Puppet/Parser/Functions.html",
    "rdoc/site/0.5.0/README_rdoc.html",
    "rdoc/site/0.5.0/Vagrant.html",
    "rdoc/site/0.5.0/Vagrant/Config.html",
    "rdoc/site/0.5.0/Vagrant/Config/Loader.html",
    "rdoc/site/0.5.0/Vagrant/Vagrantfile.html",
    "rdoc/site/0.5.0/VagrantPlugins.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Action.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Action/DeleteCache.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Action/InitKeys.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Action/LinkNetwork.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/BaseAction.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Command.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Command/Launcher.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Config.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Config/CORL.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Plugin.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Provisioner.html",
    "rdoc/site/0.5.0/VagrantPlugins/CORL/Provisioner/CORL.html",
    "rdoc/site/0.5.0/created.rid",
    "rdoc/site/0.5.0/images/add.png",
    "rdoc/site/0.5.0/images/brick.png",
    "rdoc/site/0.5.0/images/brick_link.png",
    "rdoc/site/0.5.0/images/bug.png",
    "rdoc/site/0.5.0/images/bullet_black.png",
    "rdoc/site/0.5.0/images/bullet_toggle_minus.png",
    "rdoc/site/0.5.0/images/bullet_toggle_plus.png",
    "rdoc/site/0.5.0/images/date.png",
    "rdoc/site/0.5.0/images/delete.png",
    "rdoc/site/0.5.0/images/find.png",
    "rdoc/site/0.5.0/images/loadingAnimation.gif",
    "rdoc/site/0.5.0/images/macFFBgHack.png",
    "rdoc/site/0.5.0/images/package.png",
    "rdoc/site/0.5.0/images/page_green.png",
    "rdoc/site/0.5.0/images/page_white_text.png",
    "rdoc/site/0.5.0/images/page_white_width.png",
    "rdoc/site/0.5.0/images/plugin.png",
    "rdoc/site/0.5.0/images/ruby.png",
    "rdoc/site/0.5.0/images/tag_blue.png",
    "rdoc/site/0.5.0/images/tag_green.png",
    "rdoc/site/0.5.0/images/transparent.png",
    "rdoc/site/0.5.0/images/wrench.png",
    "rdoc/site/0.5.0/images/wrench_orange.png",
    "rdoc/site/0.5.0/images/zoom.png",
    "rdoc/site/0.5.0/index.html",
    "rdoc/site/0.5.0/js/darkfish.js",
    "rdoc/site/0.5.0/js/jquery.js",
    "rdoc/site/0.5.0/js/navigation.js",
    "rdoc/site/0.5.0/js/search.js",
    "rdoc/site/0.5.0/js/search_index.js",
    "rdoc/site/0.5.0/js/searcher.js",
    "rdoc/site/0.5.0/rdoc.css",
    "rdoc/site/0.5.0/table_of_contents.html",
    "spec/corl_mock_input.rb",
    "spec/corl_test_kernel.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/coralnexus/corl"
  s.licenses = ["Apache License, Version 2.0"]
  s.rdoc_options = ["--title", "Coral Orchestration and Research Library", "--main", "README.rdoc", "--line-numbers"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.1")
  s.rubyforge_project = "corl"
  s.rubygems_version = "2.0.14"
  s.summary = "Coral Orchestration and Research Library"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nucleon>, [">= 0.2.0", "~> 0.2"])
      s.add_runtime_dependency(%q<fog>, ["~> 1.20"])
      s.add_runtime_dependency(%q<unf>, ["~> 0.1"])
      s.add_runtime_dependency(%q<facter>, ["~> 2.1"])
      s.add_runtime_dependency(%q<hiera>, ["~> 1.3"])
      s.add_runtime_dependency(%q<puppet>, ["~> 3.6"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<yard>, ["~> 0.8"])
      s.add_development_dependency(%q<vagrant>, ["~> 1.5"])
    else
      s.add_dependency(%q<nucleon>, [">= 0.2.0", "~> 0.2"])
      s.add_dependency(%q<fog>, ["~> 1.20"])
      s.add_dependency(%q<unf>, ["~> 0.1"])
      s.add_dependency(%q<facter>, ["~> 2.1"])
      s.add_dependency(%q<hiera>, ["~> 1.3"])
      s.add_dependency(%q<puppet>, ["~> 3.6"])
      s.add_dependency(%q<bundler>, ["~> 1.2"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<yard>, ["~> 0.8"])
      s.add_dependency(%q<vagrant>, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<nucleon>, [">= 0.2.0", "~> 0.2"])
    s.add_dependency(%q<fog>, ["~> 1.20"])
    s.add_dependency(%q<unf>, ["~> 0.1"])
    s.add_dependency(%q<facter>, ["~> 2.1"])
    s.add_dependency(%q<hiera>, ["~> 1.3"])
    s.add_dependency(%q<puppet>, ["~> 3.6"])
    s.add_dependency(%q<bundler>, ["~> 1.2"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<yard>, ["~> 0.8"])
    s.add_dependency(%q<vagrant>, ["~> 1.5"])
  end
end

