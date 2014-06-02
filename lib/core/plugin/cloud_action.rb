
module CORL
module Vagrant
  
  #
  # Since we can execute CORL actions from within Vagrant on a combination of
  # Vagrant VMs and remote server instances we need a way to tap into the 
  # Vagrant environment and operate on CORL configured Vagrant machines.
  # 
  # This command is set in the CORL launcher Vagrant command plugin execute 
  # method.  It is then accessible anywhere within CORL if we have used that
  # Vagrant command as an execution gateway.  If not it will be nil, giving us
  # a convienient method for checking whether we are executing through Vagrant
  # which is used in the CORL Vagrant {Node} and {Machine} plugins.
  #  
  @@command = nil
  
  def self.command=command
    @@command = command
  end
  
  def self.command
    @@command
  end  
end
end

#-------------------------------------------------------------------------------

module Nucleon
module Plugin
class CloudAction < CORL.plugin_class(:nucleon, :action)
  
  #-----------------------------------------------------------------------------
  # Property accessor / modifiers
  
  def self.namespace
    :corl
  end
  
  #---
    
  def configure
    super do
      node_config
      yield if block_given?
    end
  end
          
  #-----------------------------------------------------------------------------
  # Settings
  
  def node_config
    node_plugins = CORL.loaded_plugins(:CORL, :node)
    
    register :parallel, :bool, true, 'corl.core.action.options.parallel'
    register :net_remote, :str, :edit, 'corl.core.action.options.net_remote'
    register :net_provider, :str, :default, 'corl.core.action.options.net_provider' do |value|
      value           = value.to_sym
      network_plugins = CORL.loaded_plugins(:CORL, :network)
      
      unless network_plugins.keys.include?(value)
        warn('corl.core.action.errors.network_provider', { :value => value, :choices => network_plugins.keys.join(", ") })
        next false 
      end
      true
    end
    register :node_provider, :str, :local, 'corl.core.action.options.node_provider' do |value|
      value          = value.to_sym      
      node_providers = node_plugins.keys
      
      unless CORL.vagrant? || node_providers.include?(value)
        warn('corl.core.action.errors.node_provider', { :value => value, :choices => node_providers.join(", ") })
        next false
      end
      true  
    end
    register :nodes, :array, [], 'corl.core.action.options.nodes' do |values|
      success = true
      values.each do |value|
        if info = CORL.plugin_class(:CORL, :node).translate_reference(value)
          if ! node_plugins.keys.include?(info[:provider].to_sym) || info[:name].empty?
            warn('corl.core.action.errors.nodes', { :value => value, :provider => info[:provider],  :name => info[:name] })
            success = false
          end
        end
      end
      success
    end
  end
  
  #---
         
  def node_ignore
    [ :parallel, :net_remote, :net_provider, :node_provider, :nodes ]
  end
  
  #-----------------------------------------------------------------------------
  # Operations
  
  def validate(node, network)
    super(node, network)
  end
  
  #---
   
  def execute
    super(true, true) do
      node_exec do |node, network|
        hook_config = { :node => node, :network => network }
        
        yield(node, network) if block_given? && extension_check(:exec_init, hook_config)
        myself.status = extension_set(:exec_exit, status, hook_config)
      end
    end
  end
  
  #---
        
  def node_exec
    network = init_network
    
    #
    # A fork in the road...
    #
    if network && network.has_nodes? && ! settings[:nodes].empty?
      # Execute action on remote nodes 
      success = network.batch(settings[:nodes], settings[:node_provider], settings[:parallel]) do |node|
        exec_config = Config.new(settings)
        exec_config.delete(:parallel)
        exec_config.delete(:nodes)
        exec_config.delete(:node_provider)
              
        result = node.action(plugin_provider, exec_config) do |op, data|
          execute_remote(node, network, op, data)
        end
        result.status == code.success 
      end
      myself.status = code.batch_error unless success
    else
      # Execute statement locally
      node = nil
      node = network.local_node if network
      
      if validate(node, network)
        yield(node, network) if block_given?
      else
        puts "\n" + I18n.t('corl.core.exec.help.usage') + ': ' + help + "\n" unless quiet?
        myself.status = code.validation_failed 
      end
    end
  end
  
  #---
  
  def init_network(path = nil)
    # Get network configuration path
    if CORL.admin?
      network_path = lookup(:corl_network)
      Dir.mkdir(network_path) unless File.directory?(network_path)
    else
      network_path = ( path.nil? ? Dir.pwd : File.expand_path(path) )
    end
    
    # Load network if it exists
    network_config = extended_config(:network, { :directory => network_path })
    network        = CORL.network(network_path, network_config, settings[:net_provider])
    network  
  end
  
  #---
  
  def execute_remote(node, network, op, data)
    # Implement in sub classes if needed
    data 
  end
  
  #---
  
  def ensure_network(network, &block)
    codes :network_failure
    
    if network
      block.call
    else
      myself.status = code.network_failure
    end
  end
  
  def ensure_node(node, &block)
    codes :node_failure
    
    if node
      block.call
    else
      myself.status = code.node_failure
    end
  end
end
end
end