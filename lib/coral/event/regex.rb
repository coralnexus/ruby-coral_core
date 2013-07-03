
module Coral
module Event
class Regex < Plugin::Event
      
  #-----------------------------------------------------------------------------
  # Property accessors / modifiers
  
  def pattern(default = '')
    return get(:pattern, default)
  end
  
  #---
   
  def pattern=pattern
    set(:pattern, string(pattern))  
  end
  
  #-----------------------------------------------------------------------------
  # Plugin operations
  
  def normalize
    super
    set(:name, "#{type}:#{pattern}")
  end
 
  #-----------------------------------------------------------------------------
  # Event operations
   
  def check(source)
    if pattern.empty?
      return true if source.match(/#{pattern}/)                 
      return false
    end
    return true
  end
end
end
end
