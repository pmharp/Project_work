# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Storage::Mgmt::V2019_06_01
  module Models
    #
    # Lease Container response schema.
    #
    class LeaseContainerResponse

      include MsRestAzure

      # @return [String] Returned unique lease ID that must be included with
      # any request to delete the container, or to renew, change, or release
      # the lease.
      attr_accessor :lease_id

      # @return [String] Approximate time remaining in the lease period, in
      # seconds.
      attr_accessor :lease_time_seconds


      #
      # Mapper for LeaseContainerResponse class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'LeaseContainerResponse',
          type: {
            name: 'Composite',
            class_name: 'LeaseContainerResponse',
            model_properties: {
              lease_id: {
                client_side_validation: true,
                required: false,
                serialized_name: 'leaseId',
                type: {
                  name: 'String'
                }
              },
              lease_time_seconds: {
                client_side_validation: true,
                required: false,
                serialized_name: 'leaseTimeSeconds',
                type: {
                  name: 'String'
                }
              }
            }
          }
        }
      end
    end
  end
end
