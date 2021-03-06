
module CORL
module Mixin
module Action
module Keypair

  #-----------------------------------------------------------------------------
  # Options

  def keypair_config
    register_str :private_key, nil, 'corl.core.mixin.action.keypair.options.private_key' do |value|
      success = true
      if value
        file = File.expand_path(value)
        if File.exists?(file)
          unless Util::SSH.generate({ :private_key => file })
            warn('corl.core.mixin.action.keypair.errors.private_key_parse_error', { :value => file })
            success = false
          end
        else
          warn('corl.core.mixin.action.keypair.errors.private_key_not_found', { :value => file })
          success = false
        end
      end
      success
    end

    register_bool :require_password, false, 'corl.core.mixin.action.keypair.options.require_password'

    register_str :key_type, 'RSA', 'corl.core.mixin.action.keypair.options.key_type' do |value|
      key_type_choices = [ 'RSA', 'DSA' ]
      unless key_type_choices.include?(value.to_s.upcase)
        warn('corl.core.mixin.action.keypair.errors.key_type', { :value => value, :choices => key_type_choices })
        next false
      end
      true
    end
    register_int :key_bits, 2048, 'corl.core.mixin.action.keypair.options.key_bits' do |value|
      unless value >= 2048
        warn('corl.core.mixin.action.keypair.errors.key_bits', { :value => value, :required => 2048 })
        next false
      end
      true
    end
    register_str :key_comment, '', 'corl.core.mixin.action.keypair.options.key_comment'

    config_subset(keypair_ignore)
  end

  #---

  def keypair_ignore
    [ :require_password, :key_type, :key_bits, :key_comment ]
  end

  #---

  def keypair_clean
    remove(keypair_ignore)
  end

  #-----------------------------------------------------------------------------
  # Properties

  @keypair = nil

  #---

  def keypair=options
    config = Config.ensure(options).defaults({
      :type    => settings[:key_type].to_s.upcase,
      :bits    => settings[:key_bits],
      :comment => settings[:key_comment]
    })
    @keypair = Util::SSH.generate(config)
    settings.import({ :keypair => @keypair })
  end

  #---

  def keypair(reset = false, warn = true)
    if reset || ! @keypair
      if settings[:private_key]
        key_options = { :private_key => private_key }
      else
        key_options = {}
        if settings[:require_password]
          key_password = password('SSH')
          if key_password
            key_options[:passphrase] = key_password
          else
            warn('no_password') if warn
            return nil
          end
        end
      end
      myself.keypair = key_options
    end
    @keypair
  end
end
end
end
end

