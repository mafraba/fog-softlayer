module Fog
  module Compute
    class Softlayer

      class Mock

        # Powers on a VM
        # @param [Integer] id
        # @return [Excon::Response]
        def power_on_vm(id)
          # TODO: implement
        end
      end

      class Real

        def power_on_vm(id)
          request(:virtual_guest, "#{id.to_s}/powerOn", :http_method => :GET)
        end

      end
    end
  end
end
