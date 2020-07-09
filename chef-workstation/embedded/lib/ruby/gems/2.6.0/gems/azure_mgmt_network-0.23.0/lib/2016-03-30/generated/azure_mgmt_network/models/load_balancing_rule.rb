# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2016_03_30
  module Models
    #
    # Rules of the load balancer
    #
    class LoadBalancingRule < SubResource

      include MsRestAzure

      # @return [SubResource] Gets or sets a reference to frontend IP Addresses
      attr_accessor :frontend_ipconfiguration

      # @return [SubResource] Gets or sets  a reference to a pool of DIPs.
      # Inbound traffic is randomly load balanced across IPs in the backend IPs
      attr_accessor :backend_address_pool

      # @return [SubResource] Gets or sets the reference of the load balancer
      # probe used by the Load Balancing rule.
      attr_accessor :probe

      # @return [TransportProtocol] Gets or sets the transport protocol for the
      # external endpoint. Possible values are Udp or Tcp. Possible values
      # include: 'Udp', 'Tcp'
      attr_accessor :protocol

      # @return [LoadDistribution] Gets or sets the load distribution policy
      # for this rule. Possible values include: 'Default', 'SourceIP',
      # 'SourceIPProtocol'
      attr_accessor :load_distribution

      # @return [Integer] Gets or sets the port for the external endpoint. You
      # can specify any port number you choose, but the port numbers specified
      # for each role in the service must be unique. Possible values range
      # between 1 and 65535, inclusive
      attr_accessor :frontend_port

      # @return [Integer] Gets or sets a port used for internal connections on
      # the endpoint. The localPort attribute maps the eternal port of the
      # endpoint to an internal port on a role. This is useful in scenarios
      # where a role must communicate to an internal component on a port that
      # is different from the one that is exposed externally. If not specified,
      # the value of localPort is the same as the port attribute. Set the value
      # of localPort to '*' to automatically assign an unallocated port that is
      # discoverable using the runtime API
      attr_accessor :backend_port

      # @return [Integer] Gets or sets the timeout for the Tcp idle connection.
      # The value can be set between 4 and 30 minutes. The default value is 4
      # minutes. This element is only used when the protocol is set to Tcp
      attr_accessor :idle_timeout_in_minutes

      # @return [Boolean] Configures a virtual machine's endpoint for the
      # floating IP capability required to configure a SQL AlwaysOn
      # availability Group. This setting is required when using the SQL Always
      # ON availability Groups in SQL server. This setting can't be changed
      # after you create the endpoint
      attr_accessor :enable_floating_ip

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
      # Mapper for LoadBalancingRule class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'LoadBalancingRule',
          type: {
            name: 'Composite',
            class_name: 'LoadBalancingRule',
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
              backend_address_pool: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.backendAddressPool',
                type: {
                  name: 'Composite',
                  class_name: 'SubResource'
                }
              },
              probe: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.probe',
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
              load_distribution: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.loadDistribution',
                type: {
                  name: 'String'
                }
              },
              frontend_port: {
                client_side_validation: true,
                required: true,
                serialized_name: 'properties.frontendPort',
                type: {
                  name: 'Number'
                }
              },
              backend_port: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.backendPort',
                type: {
                  name: 'Number'
                }
              },
              idle_timeout_in_minutes: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.idleTimeoutInMinutes',
                type: {
                  name: 'Number'
                }
              },
              enable_floating_ip: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.enableFloatingIP',
                type: {
                  name: 'Boolean'
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
