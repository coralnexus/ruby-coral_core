
module Coral
module Project
class Github < Git
 
  #-----------------------------------------------------------------------------
  # Project plugin interface
 
  def normalize    
    if get(:ssh, false)
      protocol  = 'git@'
      separator = ':'
    else
      protocol  = 'https://'
      separator = '/'
    end
    set(:url, "#{protocol}github.com#{separator}" + get(:url) + '.git')
    super
  end
end
end
end
