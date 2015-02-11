module Fog
  module Compute
    class Softlayer

      class Mock

        # Starts a BM server
        # @param [Integer] id
        # @return [Excon::Response]
        def power_on_bare_metal_server(id)
          # TODO: implement
        end
      end

      class Real

        def power_on_bare_metal_server(id)
          request(:hardware_server, "#{id.to_s}/powerOn", :http_method => :GET)
        end

      end
    end
  end
end