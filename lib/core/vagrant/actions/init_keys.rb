
module VagrantPlugins
module CORL
module Action
class InitKeys < BaseAction

  def call(env)
    super do
      env[:ui].info I18n.t("corl.vagrant.actions.init_keys.start")

      if node.public_key
        ssh_key = ::CORL::Util::Disk.read(node.public_key)

        if ssh_key && ! ssh_key.empty?
          env[:machine].communicate.tap do |comm|
            comm.execute("echo '#{ssh_key}' > \$HOME/.ssh/authorized_keys")
          end
          node.set_cache_setting(:use_private_key, true)
          env[:machine].config.ssh.private_key_path = node.private_key

          # Needed for Vagrant 1.7+
          vagrant_key_file = env[:machine].data_dir.join("private_key")
          ::CORL::Util::Disk.delete(vagrant_key_file) if File.exists?(vagrant_key_file)

          node.machine.load
        end
      end
      @app.call env
    end
  end
end
end
end
end
