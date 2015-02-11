module Fog
  module Compute
    class Softlayer

      class Mock

        # Reboots a BM server
        # @param [Integer] id
        # @return [Excon::Response]
        def reboot_bare_metal_server(id, use_hard_reboot)
          # TODO: implement
        end
      end

      class Real

        def reboot_bare_metal_server(id, use_hard_reboot)
          if use_hard_reboot
            request(:hardware_server, "#{id.to_s}/rebootHard", :http_method => :GET)
          else
            request(:hardware_server, "#{id.to_s}/rebootSoft", :http_method => :GET)
          end
        end

      end
    end
  end
end