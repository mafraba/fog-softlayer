module Fog
  module Compute
    class Softlayer

      class Mock

        # Stop a BM server
        # @param [Integer] id
        # @return [Excon::Response]
        def power_off_bare_metal_server(id)
          # TODO: implement
        end
      end

      class Real

        def power_off_bare_metal_server(id)
          request(:virtual_guest, "#{id.to_s}/powerOff", :http_method => :GET)
        end

      end
    end
  end
end
