module Fog
  module Compute
    class Softlayer

      class Mock

        # Stop a VM
        # @param [Integer] id
        # @return [Excon::Response]
        def power_off_vm(id, use_hard_poweroff)
          # TODO: implement
        end
      end

      class Real

        def power_off_vm(id, use_hard_poweroff)
          if use_hard_poweroff
            request(:virtual_guest, "#{id.to_s}/powerOff", :http_method => :GET)
          else
            request(:virtual_guest, "#{id.to_s}/powerOffSoft", :http_method => :GET)
          end
        end

      end
    end
  end
end
