
module Nucleon
module Plugin
class Network < CORL.plugin_class(:base)
  
  init_plugin_collection(:add_node, :batch) 
  
  #-----------------------------------------------------------------------------
  # Cloud plugin interface
  
  def normalize(reload)
    super
    
    logger.info("Initializing sub configuration from source with: #{myself._export.inspect}")
    myself.config = CORL.configuration(Config.new(myself._export).import({ :autosave => false, :create => false })) unless reload
    
    ignore('build')
  end
  
  #---
  
  def remove_plugin
    CORL.remove_plugin(config)
    
    each_plugin do |type, provider, name, plugin|
      CORL.remove_plugin(plugin)  
    end
  end
  
  #-----------------------------------------------------------------------------
  # Checks
  
  def has_nodes?(provider = nil)   
    node_config(provider).export.empty? ? false : true
  end
       
  #-----------------------------------------------------------------------------
  # Property accessors / modifiers
  
  plugin_collection :node
  plugin_collection :provisioner
  
  #---
  
  def home
    extension_set(:home, ( ENV['USER'] == 'root' ? '/root' : ENV['HOME'] )) 
  end
  
  #---
  
  def directory
    config.directory
  end
  
  #---
  
  def build_directory
    File.join(directory, 'build')
  end
  
  #---
  
  def cache
    config.cache
  end
  
  #---
  
  def ignore(files)
    config.ignore(files)
  end
  
  #---
  
  def remote(name)
    config.remote(name)
  end
  
  def set_remote(name, location)
    config.set_remote(name, location)
  end
  
  #---
  
  def node_groups
    groups = {}
    
    each_node_config do |provider, name, info|
      search_node(provider, name, :settings, [], :array).each do |group|
        group = group.to_sym
        groups[group] = [] unless groups.has_key?(group)
        groups[group] << { :provider => provider, :name => name }
      end
    end
    groups
  end
  
  #---
  
  def node_info(references, default_provider = nil)
    groups    = node_groups
    node_info = {}
    
    default_provider = Manager.connection.type_default(:node) if default_provider.nil?
        
    references.each do |reference|
      info = Plugin::Node.translate_reference(reference)
      info = { :provider => default_provider, :name => reference } unless info
      name = info[:name].to_sym     
      
      # Check for group membership
      if groups.has_key?(name)
        groups[name].each do |member_info|
          provider = member_info[:provider].to_sym
          
          node_info[provider] = [] unless node_info.has_key?(provider)        
          node_info[provider] << member_info[:name]
        end
      else
        # Not a group
        provider = info[:provider].to_sym
        
        if node_config.export.has_key?(provider)
          node_found = false
          
          each_node_config(provider) do |node_provider, node_name, node|
            if node_name == name
              node_info[node_provider] = [] unless node_info.has_key?(node_provider)        
              node_info[node_provider] << node_name
              node_found = true
              break
            end
          end
          
          unless node_found
            # TODO:  Error or something?
          end
        end 
      end     
    end    
    node_info  
  end
  
  #---
  
  def node_by_ip(public_ip, require_new = false)
    each_node_config do |provider, name, info|
      return node(provider, name, require_new) if info[:public_ip] == public_ip  
    end
    nil
  end
  
  #---
  
  def local_node(require_new = false)
    ip_address = CORL.public_ip  
    local_node = node_by_ip(ip_address, require_new)
        
    if local_node.nil?
      name       = Util::Data.ensure_value(lookup(:fqdn), ip_address)    
      local_node = CORL.node(name, extended_config(:local_node).import({ :meta => { :parent => myself }}), :local) 
    else
      local_node.network = myself
      local_node.normalize(true)
      local_node.localize               
    end    
    local_node
  end
  
  #---
  
  def nodes_by_reference(references, default_provider = nil, require_new = false)
    nodes = []
    
    node_info(references, default_provider).each do |provider, names|
      names.each do |name|
        nodes << node(provider, name, require_new)
      end
    end
    nodes  
  end
  
  #---
  
  def test_node(provider, options = {})
    config = Config.ensure(options).import({ :meta => { :parent => myself } })
    CORL.node(:test, config.export, provider)
  end
  
  #-----------------------------------------------------------------------------
  # Operations
  
  def load(options = {})
    config.load(options)
  end
  
  #---
  
  def save(options = {})
    config.save(options)
  end
  
  #---
  
  def attach_files(type, name, files, options = {})
    attach_config  = Config.ensure(options).import({ :type => :file })
    included_files = []    
    files          = [ files ] unless files.is_a?(Array)
    
    files.each do |file|
      if file
        attached_file = config.attach(type, name, file, attach_config)
        included_files << attached_file unless attached_file.nil?
      end  
    end    
    included_files
  end
  
  #---
  
  def attach_data(type, name, data, options = {})
    attach_config = Config.ensure(options).import({ :type => :source })
    attached_data = nil    
    
    if data.is_a?(String)
      attached_data = config.attach(type, name, data, attach_config)
    end  
    attached_data
  end
  
  #---
  
  def delete_attachments(ids, options = {})
    config.delete_attachments(ids, options)    
  end
  
  #---
  
  def add_node(provider, name, options = {})
    config = Config.ensure(options)
    
    keypair = config.delete(:keypair, nil)
    return false unless keypair && keypair.is_a?(Util::SSH::Keypair)
        
    remote_name = config.delete(:remote, :edit)
    
    node_options = Util::Data.clean({ 
      :settings     => array(config.delete(:groups, [])) | [ "server" ], 
      :region       => config.delete(:region, nil),
      :machine_type => config.delete(:machine_type, nil),
      :public_ip    => config.delete(:public_ip, nil),
      :image        => config.delete(:image, nil),
      :user         => config.delete(:user, :root),
      :hostname     => name
    })
    
    # Set node data
    node        = set_node(provider, name, node_options)
    hook_config = { :node => node, :remote => remote_name, :config => config }
    success     = true
    
    yield(:preprocess, hook_config) if block_given?
    
    if ! node.local? && node.attach_keys(keypair) && extension_check(:add_node, hook_config)
      # Create new node / machine
      success = node.create do |op, data|
        block_given? ? yield("create_#{op}".to_sym, data) : data
      end
      
      if success && node.save({ :remote => remote_name, :message => "Created machine #{name} on #{provider}" })
        success = init_node(node, config.defaults({ :bootstrap => true, :seed => true })) do |op, data|
          block_given? ? yield(op, data) : data  
        end
      end
    end    
    success 
  end
  
  #---
  
  def init_node(node, options = {})
    config  = Config.ensure(options)
    success = true
    
    bootstrap = config.delete(:bootstrap, false)
    seed      = config.delete(:seed, false)
    
    unless node.cache_setting(:initialized)
      bootstrap = true
      seed      = true
    end
       
    provision = config.delete(:provision, true)
    
    if bootstrap
      # Bootstrap machine
      success = node.bootstrap(home, extended_config(:bootstrap, config)) do |op, data|
        block_given? ? yield("bootstrap_#{op}".to_sym, data) : data
      end
    end
        
    if success
      if seed
        seed_project = config.get(:project_reference, nil)
        save_config  = { :commit => true, :remote => remote_name, :push => true }
                         
        if seed_project && remote_name
          # Reset project remote
          seed_info = Plugin::Project.translate_reference(seed_project)
                    
          if seed_info
            seed_url    = seed_info[:url]
            seed_branch = seed_info[:revision] if seed_info[:revision]
          else
            seed_url = seed_project                
          end
          set_remote(:origin, seed_url) if remote_name.to_sym == :edit
          set_remote(remote_name, seed_url)
          save_config[:pull] = false
        end
          
        # Save network changes (preliminary)
        success = node.save(extended_config(:node_save, save_config))
        
        if success && seed_project
          # Seed machine with remote project reference
          result = node.seed({
            :project_reference => seed_project,
            :project_branch    => seed_branch
          }) do |op, data|
            yield("seed_#{op}".to_sym, data)
          end
          success = result.status == code.success
        end
      end
      
      node.set_cache_setting(:initialized, true) if success
      
      if success && provision
        # Run configured provisioners on machine
        result = node.provision(config) do |op, data|
          yield("provision_#{op}".to_sym, data)  
        end
        success = result.status == code.success
      end
        
      # Update local network project
      success = load({ :remote => remote_name, :pull => true }) if success
    end
    success
  end
  
  #-----------------------------------------------------------------------------
  # Utilities

  def each_node_config(provider = nil)
    node_config.export.each do |node_provider, nodes|
      if provider.nil? || provider == node_provider
        nodes.each do |name, info|
          yield(node_provider, name, info)
        end
      end
    end
  end
  
  #---
  
  def batch(node_references, default_provider = nil, parallel = true, &code)
    success = true
    
    if has_nodes? && ! node_references.empty?
      # Execute action on selected nodes      
      nodes = nodes_by_reference(node_references, default_provider)
      
      if CORL.parallel? && parallel
        values = []
        nodes.each do |node|
          values << Celluloid::Future.new(node, &code)
        end
        values  = values.map { |future| future.value }
        success = false if values.include?(false)
      else
        nodes.each do |node|
          proc_success = code.call(node)
          if proc_success == false
            success = false
            break
          end
        end  
      end
    end
    success
  end
end
end
end
