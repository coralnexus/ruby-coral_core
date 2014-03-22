# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "corl"
  s.version = "0.4.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adrian Webb"]
  s.date = "2014-03-22"
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
    "bootstrap/os/ubuntu/05_ruby.sh",
    "bootstrap/os/ubuntu/06_puppet.sh",
    "bootstrap/os/ubuntu/09_nucleon.sh",
    "bootstrap/os/ubuntu/10_corl.sh",
    "corl.gemspec",
    "lib/CORL/action/authorize.rb",
    "lib/CORL/action/bootstrap.rb",
    "lib/CORL/action/build.rb",
    "lib/CORL/action/destroy.rb",
    "lib/CORL/action/exec.rb",
    "lib/CORL/action/image.rb",
    "lib/CORL/action/images.rb",
    "lib/CORL/action/keypair.rb",
    "lib/CORL/action/lookup.rb",
    "lib/CORL/action/machines.rb",
    "lib/CORL/action/provision.rb",
    "lib/CORL/action/regions.rb",
    "lib/CORL/action/seed.rb",
    "lib/CORL/action/spawn.rb",
    "lib/CORL/action/ssh.rb",
    "lib/CORL/action/start.rb",
    "lib/CORL/action/stop.rb",
    "lib/CORL/configuration/file.rb",
    "lib/CORL/event/puppet.rb",
    "lib/CORL/machine/aws.rb",
    "lib/CORL/machine/physical.rb",
    "lib/CORL/machine/rackspace.rb",
    "lib/CORL/network/default.rb",
    "lib/CORL/node/aws.rb",
    "lib/CORL/node/local.rb",
    "lib/CORL/node/rackspace.rb",
    "lib/CORL/provisioner/puppetnode.rb",
    "lib/CORL/template/environment.rb",
    "lib/core/errors.rb",
    "lib/core/facade.rb",
    "lib/core/mixin/action/keypair.rb",
    "lib/core/mixin/lookup.rb",
    "lib/core/mixin/macro/network_settings.rb",
    "lib/core/mod/fog_aws_server.rb",
    "lib/core/mod/hiera_backend.rb",
    "lib/core/plugin/action.rb",
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
    "lib/corl.rb",
    "lib/facter/corl_build.rb",
    "lib/facter/corl_config_ready.rb",
    "lib/facter/corl_exists.rb",
    "lib/facter/corl_network.rb",
    "lib/facter/custom_facts.rb",
    "lib/facter/vagrant_exists.rb",
    "lib/hiera/corl_logger.rb",
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
    "spec/corl_mock_input.rb",
    "spec/corl_test_kernel.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/coralnexus/corl"
  s.licenses = ["GPLv3"]
  s.rdoc_options = ["--title", "Cluster Orchestration and Research Library", "--main", "README.rdoc", "--line-numbers"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.1")
  s.rubyforge_project = "corl"
  s.rubygems_version = "1.8.11"
  s.summary = "Cluster Orchestration and Research Library"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nucleon>, ["~> 0.1"])
      s.add_runtime_dependency(%q<fog>, ["~> 1.20"])
      s.add_runtime_dependency(%q<unf>, ["~> 0.1"])
      s.add_runtime_dependency(%q<facter>, ["~> 1.7"])
      s.add_runtime_dependency(%q<hiera>, ["~> 1.3"])
      s.add_runtime_dependency(%q<puppet>, ["~> 3.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<yard>, ["~> 0.8"])
    else
      s.add_dependency(%q<nucleon>, ["~> 0.1"])
      s.add_dependency(%q<fog>, ["~> 1.20"])
      s.add_dependency(%q<unf>, ["~> 0.1"])
      s.add_dependency(%q<facter>, ["~> 1.7"])
      s.add_dependency(%q<hiera>, ["~> 1.3"])
      s.add_dependency(%q<puppet>, ["~> 3.2"])
      s.add_dependency(%q<bundler>, ["~> 1.2"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<yard>, ["~> 0.8"])
    end
  else
    s.add_dependency(%q<nucleon>, ["~> 0.1"])
    s.add_dependency(%q<fog>, ["~> 1.20"])
    s.add_dependency(%q<unf>, ["~> 0.1"])
    s.add_dependency(%q<facter>, ["~> 1.7"])
    s.add_dependency(%q<hiera>, ["~> 1.3"])
    s.add_dependency(%q<puppet>, ["~> 3.2"])
    s.add_dependency(%q<bundler>, ["~> 1.2"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<yard>, ["~> 0.8"])
  end
end

