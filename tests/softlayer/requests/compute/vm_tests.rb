#
# Author:: Matt Eldridge (<matt.eldridge@us.ibm.com>)
# © Copyright IBM Corporation 2014.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

Shindo.tests("Fog::Compute[:softlayer] | server requests", ["softlayer"]) do

  @sl_connection = Fog::Compute[:softlayer]
  @vms = [{
              :hostname => "host1",
              :domain => "example.com",
              :startCpus => 1,
              :maxMemory => 1024,
              :hourlyBillingFlag => true,
              :localDiskFlag => true,
              :operatingSystemReferenceCode => "UBUNTU_LATEST"
          },
          {
              :hostname => "host2",
              :domain => "example.com",
              :startCpus => 1,
              :maxMemory => 1024,
              :hourlyBillingFlag => true,
              :localDiskFlag => true,
              :operatingSystemReferenceCode => "UBUNTU_LATEST"
          }
  ]
  @vm = @vms.first

  tests('success') do

    tests("#create_vms('#{@vms}')") do
      response = @sl_connection.create_vms(@vms)
      #data_matches_schema(Softlayer::Compute::Formats::VirtualGuest::SERVER, {:allow_extra_keys => true}) { response.body.first }
      data_matches_schema(200) { response.status }
    end

    tests("#create_vm('#{@vm}')") do
      response = @sl_connection.create_vm(@vm)
      @vm_id = response.body.first['id']
      #data_matches_schema([Softlayer::Compute::Formats::VirtualGuest::SERVER], {:allow_extra_keys => true}) { response.body }
      data_matches_schema(200) { response.status }
    end

    tests"#get_vms()" do
      response = @sl_connection.get_vms
      data_matches_schema(200) { response.status }
      #data_matches_schema(Softlayer::Compute::Formats::VirtualGuest::SERVER) { vm }
    end

    tests("#power_on_vm(#{@vm_id})") do
      response = @sl_connection.power_on_vm(@vm_id)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#power_off_vm(#{@vm_id}, false)") do
      response = @sl_connection.power_off_vm(@vm_id, false)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#power_off_vm(#{@vm_id}, true)") do
      response = @sl_connection.power_off_vm(@vm_id, true)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#reboot_vm(#{@vm_id}, false)") do
      response = @sl_connection.reboot_vm(@vm_id, false)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#reboot_vm(#{@vm_id}, true)") do
      response = @sl_connection.reboot_vm(@vm_id, true)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end

    tests("#delete_vm('#{@vm_id})'") do
      response = @sl_connection.delete_vm(@vm_id)
      data_matches_schema(true) {response.body}
      data_matches_schema(200) {response.status}
    end
  end

  tests('failure') do
    vms = @vms.dup; vms.first.delete(:hostname)
    tests("#create_vms('#{vms}')") do
      response = @sl_connection.create_vms(vms)
      data_matches_schema('SoftLayer_Exception_MissingCreationProperty'){ response.body['code'] }
      data_matches_schema(500){ response.status }
    end

    vm = @vm.dup; vm.delete('domain')
    tests("#create_vm('#{vm}')") do
      response = @sl_connection.create_vm(vm)
      data_matches_schema('SoftLayer_Exception_MissingCreationProperty'){ response.body['code'] }
      data_matches_schema(500){ response.status }
    end

    tests("#create_vms(#{@vm}").raises(ArgumentError) do
      @sl_connection.create_vms(@vm)
    end

    tests("#create_vm(#{@vms}").raises(ArgumentError) do
      @sl_connection.create_vm(@vms)
    end

    tests("#power_on_vm('99999999999999')") do
      response = @sl_connection.power_on_vm(99999999999999)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404) {response.status}
    end

    tests("#power_off_vm('99999999999999', true)") do
      response = @sl_connection.power_off_vm(99999999999999, true)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404) {response.status}
    end

    tests("#power_off_vm('99999999999999', false)") do
      response = @sl_connection.power_off_vm(99999999999999, false)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404) {response.status}
    end

    tests("#reboot_vm('99999999999999', true)") do
      response = @sl_connection.reboot_vm(99999999999999, true)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404) {response.status}
    end

    tests("#reboot_vm('99999999999999', false)") do
      response = @sl_connection.reboot_vm(99999999999999, false)
      data_matches_schema('SoftLayer_Exception_ObjectNotFound'){ response.body['code'] }
      data_matches_schema(404) {response.status}
    end

    tests("#delete_vm('99999999999999')'") do
      response = @sl_connection.delete_vm(99999999999999)
      data_matches_schema(String) {response.body}
      data_matches_schema(500) {response.status}
    end

  end
end
