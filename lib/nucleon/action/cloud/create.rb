
module Nucleon
module Action
module Cloud
class Create < Nucleon.plugin_class(:nucleon, :action)

  include Mixin::Action::Project
 
  #-----------------------------------------------------------------------------
  # Info
  
  def self.describe
    super(:cloud, :create, 1000)
  end
  
  #-----------------------------------------------------------------------------
  # Settings
  
  def configure
    super do    
      config.defaults(CORL.action_config(:project_create))      
      config[:project_reference].default = 'github:::coralnexus/network-template'
    end
  end
  
  #---
  
  def arguments
    [ :project_reference, :path ]
  end
 
  #-----------------------------------------------------------------------------
  # Operations
   
  def execute
    super do
      info('nucleon.action.cloud.create.start')
      
      project       = project_load(settings[:path], true, true)
      myself.status = code.project_failure unless project
    end
  end
end
end
end
end
