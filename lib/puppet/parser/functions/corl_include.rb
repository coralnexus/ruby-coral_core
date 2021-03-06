#
# corl_include.rb
#
# This function includes classes based on dynamic configurations.
# following this order
# - Hiera backend, if present (no prefix)
# - ::data::default::varname
# - ::varname
# - {default parameter}
#
module Puppet::Parser::Functions
  newfunction(:corl_include, :doc => <<-EOS
This function performs a lookup for a variable value in various locations following this order:
- Hiera backend, if present (no prefix)
- ::data::default::varname
- ::varname
- {default parameter}
If no value is found in the defined sources, it does not include any classes.
    EOS
) do |args|

    CORL.run do
      raise(Puppet::ParseError, "corl_include(): Define at least the variable name " +
        "given (#{args.size} for 1)") if args.size < 1

      var_name    = args[0]
      parameters  = ( args.size > 1 ? args[1] : {} )
      options     = ( args.size > 2 ? args[2] : {} )

      module_name = parent_module_name
      contexts    = [ :include, var_name ]

      default_options = {
        :node            => CORL::Provisioner::Puppetnode.node,
        :provisioner     => :puppetnode,
        :hiera_scope     => self,
        :puppet_scope    => self,
        :search          => 'core::default',
        :force           => true,
        :merge           => true,
        :undefined_value => :undef
      }

      if module_name
        config = CORL::Config.init(options, contexts, module_name, default_options)
      else
        config = CORL::Config.init_flat(options, contexts, default_options)
      end

      CORL::Util::Puppet.include(var_name, parameters, config)
    end
  end
end
