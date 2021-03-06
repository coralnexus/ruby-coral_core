
module Nucleon
module Action
module Network
class Machines < Nucleon.plugin_class(:nucleon, :cloud_action)

  #-----------------------------------------------------------------------------
  # Info

  def self.describe
    super(:network, :machines, 860)
  end

  #-----------------------------------------------------------------------------
  # Settings

  def configure
    super do
      codes :node_load_failure,
            :machine_load_failure
    end
  end

  def node_config
    super
    config[:node_provider].default = nil
  end

  #---

  def ignore
    node_ignore - [ :node_provider ]
  end

  def arguments
    [ :node_provider ]
  end

  #-----------------------------------------------------------------------------
  # Operations

  def execute
    super do |local_node|
      ensure_network do
        if node = network.test_node(settings[:node_provider])
          if machine_types = node.machine_types
            machine_types.each do |machine_type|
              prefixed_message(:info, '  ', node.render_machine_type(machine_type), { :i18n => false, :prefix => false })
            end

            myself.result = machine_types
            success('results', { :machines => machine_types.length }) if machine_types.length > 1
          else
            myself.status = code.machine_load_failure
          end
        else
          myself.status = code.node_load_failure
        end
      end
    end
  end
end
end
end
end
