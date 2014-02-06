
module Coral
module Plugin
class Machine < Base

  #-----------------------------------------------------------------------------
  # Machine plugin interface
  
  def normalize
    self.name = nil if name.to_s == plugin_provider.to_s      
  end
       
  #-----------------------------------------------------------------------------
  # Checks
  
  def created?
    false
  end
  
  #---
  
  def running?
    ( created? && false )
  end
   
  #-----------------------------------------------------------------------------
  # Property accessors / modifiers
  
  def provider=provider
    set(:provider, provider)
  end
  
  def provider
    get(:provider, nil)
  end
  
  #---
  
  def hostname=hostname
    set(:hostname, hostname)
  end
  
  def hostname
    get(:hostname, '')
  end
  
  #---
  
  def state
    nil
  end
  
  #---
  
  def public_ip=public_ip
    set(:public_ip, public_ip)
  end
  
  def public_ip
    get(:public_ip, nil)
  end
  
  #---
  
  def private_ip=private_ip
    set(:private_ip, private_ip)
  end
  
  def private_ip
    get(:private_ip, nil)
  end
  
  #---
    
  def machine_types
    []
  end
  
  #---
  
  def images
    []
  end
  
  #---
  
  def private_key=private_key
    set(:private_key, private_key)
  end
  
  def private_key
    return File.expand_path(get(:private_key)) if get(:private_key, false)
    nil
  end
  
  #---
  
  def public_key=public_key
    set(:public_key, public_key)
  end
  
  def public_key
    return File.expand_path(get(:public_key)) if get(:public_key, false)
  end
            
  #-----------------------------------------------------------------------------
  # Management 

  def create(options = {})
    success = true
    
    if created?
      logger.debug("Machine #{name} already exists")
    else
      logger.debug("Creating #{plugin_provider} machine with: #{options.inspect}")
      config  = Config.ensure(options)
      success = yield(config) if block_given?  
    end
    
    logger.warn("There was an error creating the machine #{name}") unless success
    success
  end
  
  #---
  
  def start(options = {})
    success = true
    
    if running?
      logger.debug("Machine #{name} is already running")  
    else
      logger.debug("Starting #{plugin_provider} machine with: #{options.inspect}")
      
      if created?
        config  = Config.ensure(options)
        success = yield(config) if block_given?    
      else
        logger.debug("Machine #{name} does not yet exist")
        success = create(options)
      end      
    end
    
    logger.warn("There was an error starting the machine #{name}") unless success
    success
  end
  
  #---
  
  def stop(options = {})
    success = true
    
    if running?
      logger.debug("Stopping #{plugin_provider} machine with: #{options.inspect}")
      config  = Config.ensure(options)      
      success = yield(config) if block_given?
    else
      logger.debug("Machine #{name} is not running")  
    end
    
    logger.warn("There was an error stopping the machine #{name}") unless success
    success
  end
  
  #---
  
  def reload(options = {})
    success = true
    
    if created?
      logger.debug("Reloading #{plugin_provider} machine with: #{options.inspect}")
      config  = Config.ensure(options)
      success = yield(config) if block_given?
    else
      logger.debug("Machine #{name} does not yet exist")
    end
    
    logger.warn("There was an error reloading the machine #{name}") unless success
    success
  end

  #---

  def destroy(options = {})   
    success = true
    
    if created?
      logger.debug("Destroying #{plugin_provider} machine with: #{options.inspect}")
      config  = Config.ensure(options)
      success = yield(config) if block_given?
    else
      logger.debug("Machine #{name} does not yet exist")
    end
    
    logger.warn("There was an error destroying the machine #{name}") unless success
    success
  end
  
  #---
  
  def upload(local_path, remote_path, options = {})
    success = true
    
    if running?
      logger.debug("Uploading #{local_path} to #{remote_path} on #{plugin_provider} machine with: #{options.inspect}")
      config  = Config.ensure(options)      
      success = yield(config) if block_given?
    else
      logger.debug("Machine #{name} is not running")  
    end
    
    logger.warn("There was an error uploading to the machine #{name}") unless success
    success
  end
  
  #---
  
  def download(remote_path, local_path, options = {})
    success = true
    
    if running?
      logger.debug("Downloading #{local_path} from #{remote_path} on #{plugin_provider} machine with: #{options.inspect}")
      config  = Config.ensure(options)      
      success = yield(config) if block_given?
    else
      logger.debug("Machine #{name} is not running")  
    end
    
    logger.warn("There was an error downloading from the machine #{name}") unless success
    success
  end
  
  #---
  
  def exec(commands, options = {})
    success = true
    
    if running?
      logger.debug("Executing command on #{plugin_provider} machine with: #{options.inspect}")
      config  = Config.ensure(options)      
      success = yield(config) if block_given?
    else
      logger.debug("Machine #{name} is not running")  
    end
    
    logger.warn("There was an error executing command on the machine #{name}") unless success
    success
  end
  
  #---
  
  def create_image(options = {})
    success = true
    
    if running?
      logger.debug("Creating image of #{plugin_provider} machine with: #{options.inspect}")
      config  = Config.ensure(options)      
      success = yield(config) if block_given?
    else
      logger.debug("Machine #{name} is not running")  
    end
    
    logger.warn("There was an error creating an image of the machine #{name}") unless success
    success
  end

  #-----------------------------------------------------------------------------
  # Utilities

  def translate_state(state)
    return string(state).downcase.to_sym if status
    :unknown
  end
end
end
end