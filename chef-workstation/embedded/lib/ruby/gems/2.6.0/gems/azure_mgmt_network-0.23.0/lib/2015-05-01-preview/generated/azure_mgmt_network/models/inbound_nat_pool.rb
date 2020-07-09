# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2015_05_01_preview
  module Models
    #
    # Inbound NAT pool of the loadbalancer
    #
    class InboundNatPool < SubResource

      include MsRestAzure

      # @return [SubResource] Gets or sets a reference to frontend IP Addresses
      attr_accessor :frontend_ipconfiguration

      # @return [TransportProtocol] Gets or sets the transport protocol for the
      # external endpoint. Possible values are Udp or Tcp. Possible values
      # include: 'Udp', 'Tcp'
      attr_accessor :protocol

      # @return [Integer] Gets or sets the starting port range for the NAT
      # pool. You can specify any port number you choose, but the port numbers
      # specified for each role in the service must be unique. Possible values
      # range between 1 and 65535, inclusive
      attr_accessor :frontend_port_range_start

      # @return [Integer] Gets or sets the ending port range for the NAT pool.
      # You can specify any port number you choose, but the port numbers
      # specified for each role in the service must be unique. Possible values
      # range between 1 and 65535, inclusive
      attr_accessor :frontend_port_range_end

      # @return [Integer] Gets or sets a port used for internal connections on
      # the endpoint. The localPort attribute maps the eternal port of the
      # endpoint to an internal port on a role. This is useful in scenarios
      # where a role must communicate to an internal component on a port that
      # is different from the one that is exposed externally. If not specified,
      # the value of localPort is the same as the port attribute. Set the value
      # of localPort to '*' to automatically assign an unallocated port that is
      # discoverable using the runtime API
      attr_accessor :backend_port

      # @return [String] Gets or sets Provisioning state of the PublicIP
      # resource Updating/Deleting/Failed
      attr_accessor :provisioning_state

      # @return [String] Gets name of the resource that is unique within a
      # resource group. This name can be used to access the resource
      attr_accessor :name

      # @return [String] A unique read-only string that changes whenever the
      # resource is updated
      attr_accessor :etag


      #
      # Mapper for InboundNatPool class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'InboundNatPool',
          type: {
            name: 'Composite',
            class_name: 'InboundNatPool',
            model_properties: {
              id: {
                client_side_validation: true,
                required: false,
                serialized_name: 'id',
                type: {
                  name: 'String'
                }
              },
              frontend_ipconfiguration: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.frontendIPConfiguration',
                type: {
                  name: 'Composite',
                  class_name: 'SubResource'
                }
              },
              protocol: {
                client_side_validation: true,
                required: true,
                serialized_name: 'properties.protocol',
                type: {
                  name: 'String'
                }
              },
              frontend_port_range_start: {
                client_side_validation: true,
                required: true,
                serialized_name: 'properties.frontendPortRangeStart',
                type: {
                  name: 'Number'
                }
              },
              frontend_port_range_end: {
                client_side_validation: true,
                required: true,
                serialized_name: 'properties.frontendPortRangeEnd',
                type: {
                  name: 'Number'
                }
              },
              backend_port: {
                client_side_validation: true,
                required: true,
                serialized_name: 'properties.backendPort',
                type: {
                  name: 'Number'
                }
              },
              provisioning_state: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.provisioningState',
                type: {
                  name: 'String'
                }
              },
              name: {
                client_side_validation: true,
                required: false,
                serialized_name: 'name',
                type: {
                  name: 'String'
                }
              },
              etag: {
                client_side_validation: true,
                required: false,
                serialized_name: 'etag',
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
