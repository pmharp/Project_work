# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2019_08_01
  module Models
    #
    # Vpn Client Parameters for package generation.
    #
    class VpnClientParameters

      include MsRestAzure

      # @return [ProcessorArchitecture] VPN client Processor Architecture.
      # Possible values include: 'Amd64', 'X86'
      attr_accessor :processor_architecture

      # @return [AuthenticationMethod] VPN client authentication method.
      # Possible values include: 'EAPTLS', 'EAPMSCHAPv2'
      attr_accessor :authentication_method

      # @return [String] The public certificate data for the radius server
      # authentication certificate as a Base-64 encoded string. Required only
      # if external radius authentication has been configured with EAPTLS
      # authentication.
      attr_accessor :radius_server_auth_certificate

      # @return [Array<String>] A list of client root certificates public
      # certificate data encoded as Base-64 strings. Optional parameter for
      # external radius based authentication with EAPTLS.
      attr_accessor :client_root_certificates


      #
      # Mapper for VpnClientParameters class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'VpnClientParameters',
          type: {
            name: 'Composite',
            class_name: 'VpnClientParameters',
            model_properties: {
              processor_architecture: {
                client_side_validation: true,
                required: false,
                serialized_name: 'processorArchitecture',
                type: {
                  name: 'String'
                }
              },
              authentication_method: {
                client_side_validation: true,
                required: false,
                serialized_name: 'authenticationMethod',
                type: {
                  name: 'String'
                }
              },
              radius_server_auth_certificate: {
                client_side_validation: true,
                required: false,
                serialized_name: 'radiusServerAuthCertificate',
                type: {
                  name: 'String'
                }
              },
              client_root_certificates: {
                client_side_validation: true,
                required: false,
                serialized_name: 'clientRootCertificates',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'StringElementType',
                      type: {
                        name: 'String'
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
