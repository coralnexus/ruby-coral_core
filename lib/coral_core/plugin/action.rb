
module Coral
module Plugin
class Action < Base
  
  include Mixin::Action::Node
  
  #-----------------------------------------------------------------------------
  # Default option interface
  
  class Option
    def initialize(provider, name, type, default, locale = nil, &validator)
      @provider  = provider
      @name      = name
      @type      = type
      @default   = default
      @locale    = locale.nil? ? "coral.actions.#{provider}.options.#{name}" : locale
      @validator = validator if validator
    end
    
    #---
    
    attr_reader :provider, :name, :type
    attr_accessor :default, :locale
    
    #---
    
    def validate(value, node, network)
      success = true
      if @validator
        success = @validator.call(value, node, network)
      end
      success
    end
  end

  #-----------------------------------------------------------------------------
  # Action plugin interface
  
  def self.exec_safe(provider, options)
    action_result = nil
    
    begin
      logger = Coral.logger
      
      logger.debug("Running coral action #{provider} with #{options.inspect}")
      action        = Coral.action(provider, options)
      exit_status   = action.execute
      action_result = action.result
      
    rescue Exception => error
      logger.error("Coral action #{provider} experienced an error:")
      logger.error(error.inspect)
      logger.error(error.message)
      logger.error(Coral::Util::Data.to_yaml(error.backtrace))

      Coral.ui.error(error.message, { :prefix => false }) if error.message
  
      exit_status = error.status_code if error.respond_to?(:status_code)
    end
    
    Coral.remove_plugin(action) if action

    exit_status = Coral.code.unknown_status unless exit_status.is_a?(Integer)
    { :status => exit_status, :result => action_result }  
  end
  
  def self.exec(provider, options, quiet = true)
    exec_safe(provider, { :settings => Config.ensure(options), :quiet => quiet })
  end
  
  def self.exec_cli(provider, args, quiet = false)
    results = exec_safe(provider, { :args => args, :quiet => quiet })
    results[:status]
  end
  
  #---
  
  def normalize
    args = array(delete(:args, []))
       
    @action_interface = Util::Liquid.new do |method, method_args|
      options = {}
      options = method_args[0] if method_args.length > 0
      
      quiet   = true
      quiet   = method_args[1] if method_args.length > 1
      
      self.class.exec(method, options, quiet)
    end
    
    set(:config, Config.new)
        
    if get(:settings, nil)
      # Internal processing
      configure
      set(:processed, true)
      set(:settings, Config.ensure(get(:settings)))
    else
      # External processing
      set(:settings, Config.new)
      configure
      parse_base(args)
    end   
  end
  
  #-----------------------------------------------------------------------------
  # Checks
  
  def quiet?
    get(:quiet, false)
  end
  
  #---
  
  def processed?
    get(:processed, false)
  end
  
  #-----------------------------------------------------------------------------
  # Property accessor / modifiers
  
  def config
    get(:config)
  end
  
  #---
   
  def settings
    get(:settings)
  end
  
  #---
  
  def register(name, type, default, locale = nil)
    name = name.to_sym
        
    if block_given?
      option = Option.new(plugin_provider, name, type, default, locale) do |value, success|
        yield(value, success)
      end
    else
      option = Option.new(plugin_provider, name, type, default, locale)
    end
    
    config[name]   = option
    settings[name] = option.default if settings[name].nil?
  end
  
  #---
  
  def ignore
    []
  end
    
  def options
    config.keys - arguments - ignore
  end
    
  def arguments
    []
  end
  
  #---
    
  def configure
    usage = "coral #{plugin_provider} "    
    arguments.each do |arg|
      usage << "<#{arg}> "
    end
    self.usage = usage
         
    node_config
    yield if block_given?
  end
  
  #---
  
  def usage=usage
    set(:usage, usage)
  end
  
  def usage
    get(:usage, '')
  end
  
  #---
  
  def help
    return @parser.help if @parser
    usage
  end
  
  #---
  
  def status=status
    set(:status, status)
  end
  
  def status
    get(:status, code.success)
  end

  #---
  
  def result=result
    set(:result, result)
  end
  
  def result
    get(:result, nil)
  end

  #-----------------------------------------------------------------------------
  # Status codes
    
  def code
    Coral.code
  end
  
  def codes(*codes)
    Coral.codes(*codes)
  end

  #-----------------------------------------------------------------------------
  # Operations
 
  def parse_base(args)    
    logger.info("Parsing action #{plugin_provider} with: #{args.inspect}")
    
    @parser = Util::CLI::Parser.new(args, usage) do |parser|
      parse(parser)      
      extension(:parse, { :parser => parser, :config => config })
    end
    
    if @parser 
      if @parser.processed
        set(:processed, true)
        settings.import(Util::Data.merge([ @parser.options, @parser.arguments ], true))
        logger.debug("Parse successful: #{export.inspect}")
        
      elsif @parser.options[:help] && ! quiet?
        puts I18n.t('coral.core.exec.help.usage') + ': ' + help + "\n"
        
      else
        if @parser.options[:help]
          logger.debug("Help wanted but running in silent mode")
        else
          logger.warn("Parse failed for unknown reasons")
        end
      end
    end
    self  
  end
  
  #---
  
  def parse(parser)
        
    generate = lambda do |format, name|
      formats = [ :option, :arg ]
      types   = [ :bool, :int, :float, :str, :array ]
      name    = name.to_sym
          
      if config.export.has_key?(name) && formats.include?(format.to_sym)
        option_config = config[name]
        type          = option_config.type
        default       = option_config.default
        locale        = option_config.locale        
        
        if types.include?(type.to_sym)
          value_label = "#{type.to_s.upcase}"
      
          if type == :bool
            parser.send("option_#{type}", name, default, "--[no-]#{name}", locale)        
          elsif format == :arg
            parser.send("#{format}_#{type}", name, default, locale)  
          else
            if type == :array
              parser.send("option_#{type}", name, default, "--#{name} #{value_label},...", locale)  
            else
              parser.send("option_#{type}", name, default, "--#{name} #{value_label}", locale)
            end
          end
        end           
      end
    end
     
    #---
    
    options.each do |name|
      generate.call(:option, name)  
    end
    
    arguments.each do |name|
      generate.call(:arg, name)
    end 
  end
  
  #---
  
  def validate(node, network)
    # TODO: Add extension hooks and logging
    
    # Validate all of the configurations
    success = true
    config.export.each do |name, option|
      success = false unless option.validate(settings[name], node, network)
    end
    if success
      # Check for missing arguments (in case of internal execution mode)
      arguments.each do |name|
        warn('coral.core.exec.errors.missing_argument', { :name => name })
        if settings[name.to_sym].nil?
          success = false
        end
      end
    end
    success
  end
  
  #---
   
  def execute
    logger.info("Executing action #{plugin_provider}")
    
    self.status = code.success
    self.result = nil
    
    if processed?
      node_exec do |node, network|
        hook_config = { :node => node, :network => network }
        
        begin
          yield(node, network) if block_given? && extension_check(:exec_init, hook_config)
          self.status = extension_set(:exec_exit, status, hook_config)
        ensure
          cleanup
        end
      end
    else
      if @parser.options[:help]
        self.status = code.help_wanted
      else
        self.status = code.action_unprocessed
      end
    end
    
    self.status = code.unknown_status unless status.is_a?(Integer)
    
    code_name = Codes.index(status)
    logger.warn("Execution failed for #{plugin_provider} with status #{status} (#{code_name}): #{export.inspect}") if processed? && status > 1 
    
    status
  end
  
  #---
  
  def run
    @action_interface
  end
  
  #---
  
  def cleanup
    logger.info("Running cleanup for action #{plugin_provider}")
    
    yield if block_given?
    
    # Nothing to do right now
    extension(:cleanup)
  end
  
  #-----------------------------------------------------------------------------
  # Output
  
  def render(display, options = {})
    ui.info(display, options) unless quiet? || display.empty?
  end
  
  #---
        
  def info(name, options = {})
    ui.info(I18n.t(name, Util::Data.merge([ settings.export, options ], true))) unless quiet?
  end
  
  #---
   
  def alert(display, options = {})
    ui.warn(display, options) unless quiet? || display.empty?
  end
        
  #---
       
  def warn(name, options = {})
    ui.warn(I18n.t(name, Util::Data.merge([ settings.export, options ], true))) unless quiet?  
  end
        
  #---
        
  def error(name, options = {})
    ui.error(I18n.t(name, Util::Data.merge([ settings.export, options ], true))) unless quiet?  
  end
        
  #---
        
  def success(name, options = {})
    ui.success(I18n.t(name, Util::Data.merge([ settings.export, options ], true))) unless quiet?  
  end
  
  #-----------------------------------------------------------------------------
  # Utilities
  
  def admin_exec
    if Coral.admin?
      yield if block_given?
    else
      ui.warn("The #{plugin_provider} action must be run as a machine administrator")
      self.status = code.access_denied    
    end
  end
end
end
end
