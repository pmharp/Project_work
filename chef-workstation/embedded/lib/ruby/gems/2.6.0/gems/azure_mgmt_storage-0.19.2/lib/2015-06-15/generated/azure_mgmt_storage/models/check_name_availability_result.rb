# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Storage::Mgmt::V2015_06_15
  module Models
    #
    # The CheckNameAvailability operation response.
    #
    class CheckNameAvailabilityResult

      include MsRestAzure

      # @return [Boolean] Boolean value that indicates whether the name is
      # available for you to use. If true, the name is available. If false, the
      # name has already been taken or is invalid and cannot be used.
      attr_accessor :name_available

      # @return [Reason] The reason that a storage account name could not be
      # used. The Reason element is only returned if NameAvailable is false.
      # Possible values include: 'AccountNameInvalid', 'AlreadyExists'
      attr_accessor :reason

      # @return [String] The error message explaining the Reason value in more
      # detail.
      attr_accessor :message


      #
      # Mapper for CheckNameAvailabilityResult class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'CheckNameAvailabilityResult',
          type: {
            name: 'Composite',
            class_name: 'CheckNameAvailabilityResult',
            model_properties: {
              name_available: {
                client_side_validation: true,
                required: false,
                serialized_name: 'nameAvailable',
                type: {
                  name: 'Boolean'
                }
              },
              reason: {
                client_side_validation: true,
                required: false,
                serialized_name: 'reason',
                type: {
                  name: 'Enum',
                  module: 'Reason'
                }
              },
              message: {
                client_side_validation: true,
                required: false,
                serialized_name: 'message',
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
