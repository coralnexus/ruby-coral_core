
module CORL
module Machine
class Rackspace < FogBase

  #-----------------------------------------------------------------------------
  # Checks

  #-----------------------------------------------------------------------------
  # Property accessors / modifiers

  def set_connection
    super
    Kernel.load File.join(File.dirname(__FILE__), '..', '..', 'core', 'mod', 'fog_rackspace_server.rb')
  end

  #-----------------------------------------------------------------------------
  # Management

  def init_server
    super do
      myself.plugin_name = @server.id

      node[:id]           = plugin_name
      node[:public_ip]    = @server.public_ip_address
      node[:private_ip]   = @server.private_ip_address
      node[:machine_type] = @server.flavor.id
      node[:image]        = @server.image.id if @server.image
      node.user           = @server.username unless node.user

      @server.private_key_path = node.private_key if node.private_key
      @server.public_key_path  = node.public_key if node.public_key
    end
  end

  #---

  def reload(options = {})
    super do |config|
      success = server.reboot(config.get(:type, 'SOFT'))

      server.wait_for { ready? } if success
      success
    end
  end

  #---

  def create_image(options = {})
    super do |image_name, config, success|
      image = server.create_image(image_name)
      image.wait_for { ready? }

      if image
        node[:image] = image.id
        success      = true
      end
      success
    end
  end
end
end
end
