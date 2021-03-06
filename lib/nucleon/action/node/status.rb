
module Nucleon
module Action
module Node
class Status < Nucleon.plugin_class(:nucleon, :cloud_action)

  #-----------------------------------------------------------------------------
  # Info

  def self.describe
    super(:node, :status, 800)
  end

  #-----------------------------------------------------------------------------
  # Settings

  def configure
    super do
      codes :network_save_failed

      register_nodes :status_nodes, []
      register_bool :basic
    end
  end

  #---

  def ignore
    [ :nodes ]
  end

  def arguments
    [ :status_nodes ]
  end

  #-----------------------------------------------------------------------------
  # Operations

  def execute
    super do |local_node|
      ensure_network do
        settings[:status_nodes] = [ 'all' ] if settings[:status_nodes].empty?

        batch_success = network.batch(settings[:status_nodes], settings[:node_provider], settings[:parallel]) do |node|
          unless node.is_a?(Nucleon.provider_class(:CORL, :node, :local))
            state       = node.state(true)
            state       = state.nil? ? :aborted : state.to_sym
            ssh_enabled = ''

            case state
            when :running, :active
              state = green(state.to_s)

              unless settings[:basic]
                result = node.cli.test :true

                if result.status == code.success
                  ssh_enabled = '[ ' + green('SSH connected') + ' ]'
                else
                  ssh_enabled = '[ ' + red('SSH connection failed') + ' ]'
                end
              end

            when :stopped, :aborted
              state = red(state.to_s)
            end
            info(state.to_s + " #{ssh_enabled}".rstrip, { :i18n => false, :prefix_text => yellow(node.plugin_provider) + ' ' + purple(node.plugin_name) })
          end
          true
        end
        if batch_success
          success = network.save({ :push => true, :remote => :edit, :message => "Updating node status information.", :allow_empty => true })
          myself.status = code.network_save_failed unless success
        else
          myself.status = code.batch_error
        end
      end
    end
  end
end
end
end
end
