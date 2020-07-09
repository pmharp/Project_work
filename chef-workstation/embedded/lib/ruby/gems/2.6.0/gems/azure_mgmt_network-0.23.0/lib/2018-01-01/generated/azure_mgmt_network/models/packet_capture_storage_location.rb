# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2018_01_01
  module Models
    #
    # Describes the storage location for a packet capture session.
    #
    class PacketCaptureStorageLocation

      include MsRestAzure

      # @return [String] The ID of the storage account to save the packet
      # capture session. Required if no local file path is provided.
      attr_accessor :storage_id

      # @return [String] The URI of the storage path to save the packet
      # capture. Must be a well-formed URI describing the location to save the
      # packet capture.
      attr_accessor :storage_path

      # @return [String] A valid local path on the targeting VM. Must include
      # the name of the capture file (*.cap). For linux virtual machine it must
      # start with /var/captures. Required if no storage ID is provided,
      # otherwise optional.
      attr_accessor :file_path


      #
      # Mapper for PacketCaptureStorageLocation class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'PacketCaptureStorageLocation',
          type: {
            name: 'Composite',
            class_name: 'PacketCaptureStorageLocation',
            model_properties: {
              storage_id: {
                client_side_validation: true,
                required: false,
                serialized_name: 'storageId',
                type: {
                  name: 'String'
                }
              },
              storage_path: {
                client_side_validation: true,
                required: false,
                serialized_name: 'storagePath',
                type: {
                  name: 'String'
                }
              },
              file_path: {
                client_side_validation: true,
                required: false,
                serialized_name: 'filePath',
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
