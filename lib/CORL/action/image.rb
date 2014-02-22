
module CORL
module Action
class Image < Plugin::CloudAction
 
  #-----------------------------------------------------------------------------
  # Settings
  
  def configure
    super do
      codes :network_failure  
    end
  end
 
  #-----------------------------------------------------------------------------
  # Operations
   
  def execute
    super do |node, network|
      info('corl.actions.image.start')
      
      if network && node
        
      else
        myself.status = code.network_failure
      end    
    end
  end
end
end
end
