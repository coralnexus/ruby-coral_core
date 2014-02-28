
module CORL
module Action
class Destroy < Plugin::CloudAction
 
  #-----------------------------------------------------------------------------
  # Settings
  
  def configure
    super do
      codes :network_failure
            
      register :destroy_nodes, :array, nil do |values|
        if values.nil?
          warn('corl.actions.destroy.errors.destroy_nodes_empty')
          next false 
        end
        
        node_plugins = CORL.loaded_plugins(:node)
        success      = true
        
        values.each do |value|
          if info = CORL.plugin_class(:node).translate_reference(value)
            if ! node_plugins.keys.include?(info[:provider].to_sym) || info[:name].empty?
              warn('corl.actions.destroy.errors.destroy_nodes', { :value => value, :node_provider => info[:provider],  :name => info[:name] })
              success = false
            end
          end
        end
        success
      end
    end
  end
  
  #---
  
  def ignore
    [ :nodes ]
  end
  
  def arguments
    [ :destroy_nodes ]
  end

  #-----------------------------------------------------------------------------
  # Operations
   
  def execute
    super do |local_node, network|
      info('corl.actions.destroy.start')
      
      if network
        batch_success = network.batch(settings[:destroy_nodes], settings[:node_provider], settings[:parallel]) do |node|
          node.destroy
        end
        myself.status = code.batch_error unless batch_success
      else
        myself.status = code.network_failure  
      end
    end
  end
end
end
end