#
# interpolate.rb
#
# Interpolate values from one hash to another for configuration injection.
#
module Puppet::Parser::Functions
  newfunction(:interpolate, :type => :rvalue, :doc => <<-EOS
This function interpolates values from one hash to another for configuration injections.
    EOS
) do |args|
    
    value = nil
    Coral.run do
      raise(Puppet::ParseError, "interpolate(): Define at least a property name with optional source configurations " +
        "given (#{args.size} for 2)") if args.size < 1
      
      value   = args[0]
      data    = ( args.size > 1 ? args[1] : {} )
      options = ( args.size > 2 ? args[2] : {} )
      
      config = Coral::Config.init_flat(options, [ :data, :interpolate ])
      value  = Coral::Util::Data.interpolate(value, data, config.options)
    end
    return value
  end
end