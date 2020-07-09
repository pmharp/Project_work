# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Storage::Mgmt::V2019_06_01
  module Models
    #
    # Sets the CORS rules. You can include up to five CorsRule elements in the
    # request.
    #
    class CorsRules

      include MsRestAzure

      # @return [Array<CorsRule>] The List of CORS rules. You can include up to
      # five CorsRule elements in the request.
      attr_accessor :cors_rules


      #
      # Mapper for CorsRules class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'CorsRules',
          type: {
            name: 'Composite',
            class_name: 'CorsRules',
            model_properties: {
              cors_rules: {
                client_side_validation: true,
                required: false,
                serialized_name: 'corsRules',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'CorsRuleElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'CorsRule'
                      }
                  }
                }
              }
            }
          }
        }
      end
    end
  end
end
