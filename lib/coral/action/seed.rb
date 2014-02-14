
module Coral
module Action
class Seed < Plugin::Action
 
  #-----------------------------------------------------------------------------
  # Settings
  
  def configure
    super do
      codes :key_store_failure,
            :project_failure,
            :network_init_failure,
            :network_load_failure,
            :node_load_failure,
            :node_save_failure
      #---
      
      register :project_branch, :str, 'master'
      register :project_reference, :str, nil do |value|
        value           = value.to_sym
        project_plugins = Plugin.loaded_plugins(:project)
        
        if @project_info = Plugin::Project.translate_reference(value, true)
          provider = @project_info[:provider]
        else
          provider = value
        end
        
        unless project_plugins.keys.include?(provider.to_sym)
          warn('coral.actions.seed.errors.project_reference', { :value => value, :provider => provider, :choices => project_plugins.keys.join(', ') })
          next false
        end
        true
      end      
    end
  end
  
  #---
  
  def arguments
    [ :project_reference ]
  end

  #-----------------------------------------------------------------------------
  # Operations
   
  def execute
    super do |node, network|
      info('coral.core.actions.seed.start')
      
      if node && network
        admin_exec do
          network_path = lookup(:coral_network)
          backup_path  = File.join(Dir.tmpdir(), 'coral')
          
          render("Generating network SSH deploy keys")
          
          if keys = Util::SSH.generate.store
            if @project_info
              project_info = Config.new(@project_info)
            else
              project_info = Config.new({ :provider => :git })
            end
            
            render("Backing up current network configuration")
            FileUtils.rm_rf(backup_path)
            FileUtils.mv(network_path, backup_path)
            
            render("Seeding network configuration from #{settings[:project_reference]}")
            project = Coral.project(extended_config(:project, {
              :directory => network_path,
              :reference => project_info.get(:reference, nil),
              :url       => project_info.get(:url, settings[:project_reference]),
              :revision  => project_info.get(:revision, settings[:project_branch]),
              :create    => true,
              :pull      => true,
              :keys      => keys
            }), project_info[:provider])
        
            if project
              render("Finalizing network path and removing temporary backup")
              FileUtils.chmod_R(0600, network_path)
              FileUtils.rm_rf(backup_path)
              
              render("Reinitializing network")
              if network = init_network
                if network.load
                  if node = network.local_node
                    render("Updating node network configurations")
                    self.status = code.node_save_failure unless node.save  
                  else
                    self.status = code.node_load_failure
                  end                  
                else
                  self.status = code.network_load_failure    
                end
              else
                self.status = code.network_init_failure
              end     
            else
              self.status = code.project_failure  
            end            
          else
            self.status = code.key_store_failure
          end
        end
      else
        self.status = code.network_load_failure    
      end
    end
  end
  
  #---
  
  def execute_remote(node, network, op, data)
    case op
    when :config # Modify seed execution configurations
      render("Starting remote execution of seed action")  
    when :progress # Report progress of seed execution
      if data[:type] == :error
        alert(data[:data])
      else
        render(data[:data])
      end  
    when :process # Process final result
      render("Successfully finished remote execution of seed package")     
    end
    data  
  end
end
end
end
