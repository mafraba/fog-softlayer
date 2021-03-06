module Fog
  module Compute
    class Softlayer

      class Mock

        # Powers on a VM
        # @param [Integer] id
        # @return [Excon::Response]
        def power_on_vm(id)
          response = Excon::Response.new
          response.status = 200
          found = self.get_vms.body.map{|server| server['id']}.include?(id)
          if not found
            response.status = 404
            response.body = {
              "error" => "Unable to find object with id of '#{id}'.",
              "code" => "SoftLayer_Exception_ObjectNotFound"
            }
          else
            response.body = true
          end
          response
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
