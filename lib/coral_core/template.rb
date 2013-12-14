
module Coral
module Template
  
  #-----------------------------------------------------------------------------
  # General template utilities
  
  def self.instance(class_name, options = {}, defaults = {}, force = true)
    return Template::const_get(class_name).new(options, defaults, force)
  end
  
  #---
  
  def self.process(value)
    case value
    when String, Symbol
      return nil        if Util::Data.undef?(value)
      return 'false'    if value == false
      return 'true'     if value == true      
      return value.to_s if value.is_a?(Symbol)
      
    when Hash
      results = {}
      value.each do |key, item|
        result = process(item)
        unless result.nil?
          results[key] = result  
        end
        value = results
      end
      
    when Array
      results = []
      value.each_with_index do |item, index|
        result = process(item)
        unless result.nil?
          results << result  
        end        
      end
      value = results
    end
    return value
  end
  
  #---
  
  def self.render(class_name, data, options = {})
    config = Config.ensure(options)
    
    normalize   = config.get(:normalize_template, true)
    interpolate = config.get(:interpolate_template, true)
    
    #dbg(class_name, 'template engine name')
    #dbg(data, 'template data -> init')
    
    if normalize
      data = Config.normalize(data, nil, config)
      #dbg(data, 'template data -> post normalization')
    end
    
    if normalize && interpolate
      data = Util::Data.interpolate(data, data, config.options)
      #dbg(data, 'template data -> post interpolation')
    end
    
    engine = instance(class_name, config, {}, config.get(:force, true))
    #dbg(engine, 'template engine')
    
    output = engine.render(process(data))
    #dbg(output, 'template output')
    
    return output
  end

  #-----------------------------------------------------------------------------
  # Base template
  
class Base < Config
  # All template classes should extend Base
  
  def intialize(options = {}, defaults = {}, force = true)
    super(options, defaults, force)
  end
  
  #---
  
  def render(input)
    return ''  # Implement in sub classes!! 
  end
end
end
end