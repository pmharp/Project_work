# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2019_09_01
  module Models
    #
    # Subnet in a virtual network resource.
    #
    class Subnet < SubResource

      include MsRestAzure

      # @return [String] The address prefix for the subnet.
      attr_accessor :address_prefix

      # @return [Array<String>] List of address prefixes for the subnet.
      attr_accessor :address_prefixes

      # @return [NetworkSecurityGroup] The reference of the
      # NetworkSecurityGroup resource.
      attr_accessor :network_security_group

      # @return [RouteTable] The reference of the RouteTable resource.
      attr_accessor :route_table

      # @return [SubResource] Nat gateway associated with this subnet.
      attr_accessor :nat_gateway

      # @return [Array<ServiceEndpointPropertiesFormat>] An array of service
      # endpoints.
      attr_accessor :service_endpoints

      # @return [Array<ServiceEndpointPolicy>] An array of service endpoint
      # policies.
      attr_accessor :service_endpoint_policies

      # @return [Array<PrivateEndpoint>] An array of references to private
      # endpoints.
      attr_accessor :private_endpoints

      # @return [Array<IPConfiguration>] An array of references to the network
      # interface IP configurations using subnet.
      attr_accessor :ip_configurations

      # @return [Array<IPConfigurationProfile>] Array of IP configuration
      # profiles which reference this subnet.
      attr_accessor :ip_configuration_profiles

      # @return [Array<ResourceNavigationLink>] An array of references to the
      # external resources using subnet.
      attr_accessor :resource_navigation_links

      # @return [Array<ServiceAssociationLink>] An array of references to
      # services injecting into this subnet.
      attr_accessor :service_association_links

      # @return [Array<Delegation>] An array of references to the delegations
      # on the subnet.
      attr_accessor :delegations

      # @return [String] A read-only string identifying the intention of use
      # for this subnet based on delegations and other user-defined properties.
      attr_accessor :purpose

      # @return [ProvisioningState] The provisioning state of the subnet
      # resource. Possible values include: 'Succeeded', 'Updating', 'Deleting',
      # 'Failed'
      attr_accessor :provisioning_state

      # @return [String] Enable or Disable apply network policies on private
      # end point in the subnet.
      attr_accessor :private_endpoint_network_policies

      # @return [String] Enable or Disable apply network policies on private
      # link service in the subnet.
      attr_accessor :private_link_service_network_policies

      # @return [String] The name of the resource that is unique within a
      # resource group. This name can be used to access the resource.
      attr_accessor :name

      # @return [String] A unique read-only string that changes whenever the
      # resource is updated.
      attr_accessor :etag


      #
      # Mapper for Subnet class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'Subnet',
          type: {
            name: 'Composite',
            class_name: 'Subnet',
            model_properties: {
              id: {
                client_side_validation: true,
                required: false,
                serialized_name: 'id',
                type: {
                  name: 'String'
                }
              },
              address_prefix: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.addressPrefix',
                type: {
                  name: 'String'
                }
              },
              address_prefixes: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.addressPrefixes',
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
              },
              network_security_group: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.networkSecurityGroup',
                type: {
                  name: 'Composite',
                  class_name: 'NetworkSecurityGroup'
                }
              },
              route_table: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.routeTable',
                type: {
                  name: 'Composite',
                  class_name: 'RouteTable'
                }
              },
              nat_gateway: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.natGateway',
                type: {
                  name: 'Composite',
                  class_name: 'SubResource'
                }
              },
              service_endpoints: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.serviceEndpoints',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'ServiceEndpointPropertiesFormatElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'ServiceEndpointPropertiesFormat'
                      }
                  }
                }
              },
              service_endpoint_policies: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.serviceEndpointPolicies',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'ServiceEndpointPolicyElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'ServiceEndpointPolicy'
                      }
                  }
                }
              },
              private_endpoints: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.privateEndpoints',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'PrivateEndpointElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'PrivateEndpoint'
                      }
                  }
                }
              },
              ip_configurations: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.ipConfigurations',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'IPConfigurationElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'IPConfiguration'
                      }
                  }
                }
              },
              ip_configuration_profiles: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.ipConfigurationProfiles',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'IPConfigurationProfileElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'IPConfigurationProfile'
                      }
                  }
                }
              },
              resource_navigation_links: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.resourceNavigationLinks',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'ResourceNavigationLinkElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'ResourceNavigationLink'
                      }
                  }
                }
              },
              service_association_links: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.serviceAssociationLinks',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'ServiceAssociationLinkElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'ServiceAssociationLink'
                      }
                  }
                }
              },
              delegations: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.delegations',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'DelegationElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'Delegation'
                      }
                  }
                }
              },
              purpose: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.purpose',
                type: {
                  name: 'String'
                }
              },
              provisioning_state: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.provisioningState',
                type: {
                  name: 'String'
                }
              },
              private_endpoint_network_policies: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.privateEndpointNetworkPolicies',
                type: {
                  name: 'String'
                }
              },
              private_link_service_network_policies: {
                client_side_validation: true,
                required: false,
                serialized_name: 'properties.privateLinkServiceNetworkPolicies',
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
                read_only: true,
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
