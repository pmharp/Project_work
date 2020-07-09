# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2018_06_01
  module Models
    #
    # Encryption settings for disk or snapshot
    #
    class EncryptionSettings

      include MsRestAzure

      # @return [Boolean] Set this flag to true and provide DiskEncryptionKey
      # and optional KeyEncryptionKey to enable encryption. Set this flag to
      # false and remove DiskEncryptionKey and KeyEncryptionKey to disable
      # encryption. If EncryptionSettings is null in the request object, the
      # existing settings remain unchanged.
      attr_accessor :enabled

      # @return [KeyVaultAndSecretReference] Key Vault Secret Url and vault id
      # of the disk encryption key
      attr_accessor :disk_encryption_key

      # @return [KeyVaultAndKeyReference] Key Vault Key Url and vault id of the
      # key encryption key
      attr_accessor :key_encryption_key


      #
      # Mapper for EncryptionSettings class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'EncryptionSettings',
          type: {
            name: 'Composite',
            class_name: 'EncryptionSettings',
            model_properties: {
              enabled: {
                client_side_validation: true,
                required: false,
                serialized_name: 'enabled',
                type: {
                  name: 'Boolean'
                }
              },
              disk_encryption_key: {
                client_side_validation: true,
                required: false,
                serialized_name: 'diskEncryptionKey',
                type: {
                  name: 'Composite',
                  class_name: 'KeyVaultAndSecretReference'
                }
              },
              key_encryption_key: {
                client_side_validation: true,
                required: false,
                serialized_name: 'keyEncryptionKey',
                type: {
                  name: 'Composite',
                  class_name: 'KeyVaultAndKeyReference'
                }
              }
            }
          }
        }
      end
    end
  end
end
