module Fog
  module Compute
    class Softlayer

      class Mock

        # Reboots a VM
        # @param [Integer] id
        # @return [Excon::Response]
        def reboot_vm(id, use_hard_reboot)
          # TODO: implement
        end
      end

      class Real

        def reboot_vm(id, use_hard_reboot)
          if use_hard_reboot
            request(:virtual_guest, "#{id.to_s}/rebootHard", :http_method => :GET)
          else
            request(:virtual_guest, "#{id.to_s}/rebootSoft", :http_method => :GET)
          end
        end

      end
    end
  end
end