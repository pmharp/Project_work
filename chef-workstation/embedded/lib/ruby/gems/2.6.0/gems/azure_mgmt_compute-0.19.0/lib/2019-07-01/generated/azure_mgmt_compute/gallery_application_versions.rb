# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2019_07_01
  #
  # Compute Client
  #
  class GalleryApplicationVersions
    include MsRestAzure

    #
    # Creates and initializes a new instance of the GalleryApplicationVersions class.
    # @param client service class for accessing basic functionality.
    #
    def initialize(client)
      @client = client
    end

    # @return [ComputeManagementClient] reference to the ComputeManagementClient
    attr_reader :client

    #
    # Create or update a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version is to be created.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be created. Needs to follow semantic version name
    # pattern: The allowed characters are digit and period. Digits must be within
    # the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>
    # @param gallery_application_version [GalleryApplicationVersion] Parameters
    # supplied to the create or update gallery Application Version operation.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [GalleryApplicationVersion] operation results.
    #
    def create_or_update(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:nil)
      response = create_or_update_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version is to be created.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be created. Needs to follow semantic version name
    # pattern: The allowed characters are digit and period. Digits must be within
    # the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>
    # @param gallery_application_version [GalleryApplicationVersion] Parameters
    # supplied to the create or update gallery Application Version operation.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [Concurrent::Promise] promise which provides async access to http
    # response.
    #
    def create_or_update_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:nil)
      # Send request
      promise = begin_create_or_update_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:custom_headers)

      promise = promise.then do |response|
        # Defining deserialization method.
        deserialize_method = lambda do |parsed_response|
          result_mapper = Azure::Compute::Mgmt::V2019_07_01::Models::GalleryApplicationVersion.mapper()
          parsed_response = @client.deserialize(result_mapper, parsed_response)
        end

        # Waiting for response.
        @client.get_long_running_operation_result(response, deserialize_method)
      end

      promise
    end

    #
    # Retrieves information about a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version resides.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be retrieved.
    # @param expand [ReplicationStatusTypes] The expand expression to apply on the
    # operation. Possible values include: 'ReplicationStatus'
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [GalleryApplicationVersion] operation results.
    #
    def get(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, expand:nil, custom_headers:nil)
      response = get_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, expand:expand, custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # Retrieves information about a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version resides.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be retrieved.
    # @param expand [ReplicationStatusTypes] The expand expression to apply on the
    # operation. Possible values include: 'ReplicationStatus'
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRestAzure::AzureOperationResponse] HTTP response information.
    #
    def get_with_http_info(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, expand:nil, custom_headers:nil)
      get_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, expand:expand, custom_headers:custom_headers).value!
    end

    #
    # Retrieves information about a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version resides.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be retrieved.
    # @param expand [ReplicationStatusTypes] The expand expression to apply on the
    # operation. Possible values include: 'ReplicationStatus'
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def get_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, expand:nil, custom_headers:nil)
      fail ArgumentError, '@client.subscription_id is nil' if @client.subscription_id.nil?
      fail ArgumentError, 'resource_group_name is nil' if resource_group_name.nil?
      fail ArgumentError, 'gallery_name is nil' if gallery_name.nil?
      fail ArgumentError, 'gallery_application_name is nil' if gallery_application_name.nil?
      fail ArgumentError, 'gallery_application_version_name is nil' if gallery_application_version_name.nil?
      fail ArgumentError, '@client.api_version is nil' if @client.api_version.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json; charset=utf-8'

      # Set Headers
      request_headers['x-ms-client-request-id'] = SecureRandom.uuid
      request_headers['accept-language'] = @client.accept_language unless @client.accept_language.nil?
      path_template = 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{galleryApplicationName}/versions/{galleryApplicationVersionName}'

      request_url = @base_url || @client.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'subscriptionId' => @client.subscription_id,'resourceGroupName' => resource_group_name,'galleryName' => gallery_name,'galleryApplicationName' => gallery_application_name,'galleryApplicationVersionName' => gallery_application_version_name},
          query_params: {'$expand' => expand,'api-version' => @client.api_version},
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = @client.make_request_async(:get, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRestAzure::AzureOperationError.new(result.request, http_response, error_model)
        end

        result.request_id = http_response['x-ms-request-id'] unless http_response['x-ms-request-id'].nil?
        result.correlation_request_id = http_response['x-ms-correlation-request-id'] unless http_response['x-ms-correlation-request-id'].nil?
        result.client_request_id = http_response['x-ms-client-request-id'] unless http_response['x-ms-client-request-id'].nil?
        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = Azure::Compute::Mgmt::V2019_07_01::Models::GalleryApplicationVersion.mapper()
            result.body = @client.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end

    #
    # Delete a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version resides.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be deleted.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    def delete(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:nil)
      response = delete_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:custom_headers).value!
      nil
    end

    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version resides.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be deleted.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [Concurrent::Promise] promise which provides async access to http
    # response.
    #
    def delete_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:nil)
      # Send request
      promise = begin_delete_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:custom_headers)

      promise = promise.then do |response|
        # Defining deserialization method.
        deserialize_method = lambda do |parsed_response|
        end

        # Waiting for response.
        @client.get_long_running_operation_result(response, deserialize_method)
      end

      promise
    end

    #
    # List gallery Application Versions in a gallery Application Definition.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the Shared Application
    # Gallery Application Definition from which the Application Versions are to be
    # listed.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [Array<GalleryApplicationVersion>] operation results.
    #
    def list_by_gallery_application(resource_group_name, gallery_name, gallery_application_name, custom_headers:nil)
      first_page = list_by_gallery_application_as_lazy(resource_group_name, gallery_name, gallery_application_name, custom_headers:custom_headers)
      first_page.get_all_items
    end

    #
    # List gallery Application Versions in a gallery Application Definition.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the Shared Application
    # Gallery Application Definition from which the Application Versions are to be
    # listed.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRestAzure::AzureOperationResponse] HTTP response information.
    #
    def list_by_gallery_application_with_http_info(resource_group_name, gallery_name, gallery_application_name, custom_headers:nil)
      list_by_gallery_application_async(resource_group_name, gallery_name, gallery_application_name, custom_headers:custom_headers).value!
    end

    #
    # List gallery Application Versions in a gallery Application Definition.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the Shared Application
    # Gallery Application Definition from which the Application Versions are to be
    # listed.
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def list_by_gallery_application_async(resource_group_name, gallery_name, gallery_application_name, custom_headers:nil)
      fail ArgumentError, '@client.subscription_id is nil' if @client.subscription_id.nil?
      fail ArgumentError, 'resource_group_name is nil' if resource_group_name.nil?
      fail ArgumentError, 'gallery_name is nil' if gallery_name.nil?
      fail ArgumentError, 'gallery_application_name is nil' if gallery_application_name.nil?
      fail ArgumentError, '@client.api_version is nil' if @client.api_version.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json; charset=utf-8'

      # Set Headers
      request_headers['x-ms-client-request-id'] = SecureRandom.uuid
      request_headers['accept-language'] = @client.accept_language unless @client.accept_language.nil?
      path_template = 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{galleryApplicationName}/versions'

      request_url = @base_url || @client.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'subscriptionId' => @client.subscription_id,'resourceGroupName' => resource_group_name,'galleryName' => gallery_name,'galleryApplicationName' => gallery_application_name},
          query_params: {'api-version' => @client.api_version},
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = @client.make_request_async(:get, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRestAzure::AzureOperationError.new(result.request, http_response, error_model)
        end

        result.request_id = http_response['x-ms-request-id'] unless http_response['x-ms-request-id'].nil?
        result.correlation_request_id = http_response['x-ms-correlation-request-id'] unless http_response['x-ms-correlation-request-id'].nil?
        result.client_request_id = http_response['x-ms-client-request-id'] unless http_response['x-ms-client-request-id'].nil?
        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = Azure::Compute::Mgmt::V2019_07_01::Models::GalleryApplicationVersionList.mapper()
            result.body = @client.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end

    #
    # Create or update a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version is to be created.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be created. Needs to follow semantic version name
    # pattern: The allowed characters are digit and period. Digits must be within
    # the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>
    # @param gallery_application_version [GalleryApplicationVersion] Parameters
    # supplied to the create or update gallery Application Version operation.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [GalleryApplicationVersion] operation results.
    #
    def begin_create_or_update(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:nil)
      response = begin_create_or_update_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # Create or update a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version is to be created.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be created. Needs to follow semantic version name
    # pattern: The allowed characters are digit and period. Digits must be within
    # the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>
    # @param gallery_application_version [GalleryApplicationVersion] Parameters
    # supplied to the create or update gallery Application Version operation.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRestAzure::AzureOperationResponse] HTTP response information.
    #
    def begin_create_or_update_with_http_info(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:nil)
      begin_create_or_update_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:custom_headers).value!
    end

    #
    # Create or update a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version is to be created.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be created. Needs to follow semantic version name
    # pattern: The allowed characters are digit and period. Digits must be within
    # the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>
    # @param gallery_application_version [GalleryApplicationVersion] Parameters
    # supplied to the create or update gallery Application Version operation.
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def begin_create_or_update_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, gallery_application_version, custom_headers:nil)
      fail ArgumentError, '@client.subscription_id is nil' if @client.subscription_id.nil?
      fail ArgumentError, 'resource_group_name is nil' if resource_group_name.nil?
      fail ArgumentError, 'gallery_name is nil' if gallery_name.nil?
      fail ArgumentError, 'gallery_application_name is nil' if gallery_application_name.nil?
      fail ArgumentError, 'gallery_application_version_name is nil' if gallery_application_version_name.nil?
      fail ArgumentError, '@client.api_version is nil' if @client.api_version.nil?
      fail ArgumentError, 'gallery_application_version is nil' if gallery_application_version.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json; charset=utf-8'

      # Set Headers
      request_headers['x-ms-client-request-id'] = SecureRandom.uuid
      request_headers['accept-language'] = @client.accept_language unless @client.accept_language.nil?

      # Serialize Request
      request_mapper = Azure::Compute::Mgmt::V2019_07_01::Models::GalleryApplicationVersion.mapper()
      request_content = @client.serialize(request_mapper,  gallery_application_version)
      request_content = request_content != nil ? JSON.generate(request_content, quirks_mode: true) : nil

      path_template = 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{galleryApplicationName}/versions/{galleryApplicationVersionName}'

      request_url = @base_url || @client.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'subscriptionId' => @client.subscription_id,'resourceGroupName' => resource_group_name,'galleryName' => gallery_name,'galleryApplicationName' => gallery_application_name,'galleryApplicationVersionName' => gallery_application_version_name},
          query_params: {'api-version' => @client.api_version},
          body: request_content,
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = @client.make_request_async(:put, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200 || status_code == 201 || status_code == 202
          error_model = JSON.load(response_content)
          fail MsRestAzure::AzureOperationError.new(result.request, http_response, error_model)
        end

        result.request_id = http_response['x-ms-request-id'] unless http_response['x-ms-request-id'].nil?
        result.correlation_request_id = http_response['x-ms-correlation-request-id'] unless http_response['x-ms-correlation-request-id'].nil?
        result.client_request_id = http_response['x-ms-client-request-id'] unless http_response['x-ms-client-request-id'].nil?
        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = Azure::Compute::Mgmt::V2019_07_01::Models::GalleryApplicationVersion.mapper()
            result.body = @client.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end
        # Deserialize Response
        if status_code == 201
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = Azure::Compute::Mgmt::V2019_07_01::Models::GalleryApplicationVersion.mapper()
            result.body = @client.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end
        # Deserialize Response
        if status_code == 202
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = Azure::Compute::Mgmt::V2019_07_01::Models::GalleryApplicationVersion.mapper()
            result.body = @client.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end

    #
    # Delete a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version resides.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be deleted.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    #
    def begin_delete(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:nil)
      response = begin_delete_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:custom_headers).value!
      nil
    end

    #
    # Delete a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version resides.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be deleted.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRestAzure::AzureOperationResponse] HTTP response information.
    #
    def begin_delete_with_http_info(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:nil)
      begin_delete_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:custom_headers).value!
    end

    #
    # Delete a gallery Application Version.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the gallery Application
    # Definition in which the Application Version resides.
    # @param gallery_application_version_name [String] The name of the gallery
    # Application Version to be deleted.
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def begin_delete_async(resource_group_name, gallery_name, gallery_application_name, gallery_application_version_name, custom_headers:nil)
      fail ArgumentError, '@client.subscription_id is nil' if @client.subscription_id.nil?
      fail ArgumentError, 'resource_group_name is nil' if resource_group_name.nil?
      fail ArgumentError, 'gallery_name is nil' if gallery_name.nil?
      fail ArgumentError, 'gallery_application_name is nil' if gallery_application_name.nil?
      fail ArgumentError, 'gallery_application_version_name is nil' if gallery_application_version_name.nil?
      fail ArgumentError, '@client.api_version is nil' if @client.api_version.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json; charset=utf-8'

      # Set Headers
      request_headers['x-ms-client-request-id'] = SecureRandom.uuid
      request_headers['accept-language'] = @client.accept_language unless @client.accept_language.nil?
      path_template = 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{galleryApplicationName}/versions/{galleryApplicationVersionName}'

      request_url = @base_url || @client.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'subscriptionId' => @client.subscription_id,'resourceGroupName' => resource_group_name,'galleryName' => gallery_name,'galleryApplicationName' => gallery_application_name,'galleryApplicationVersionName' => gallery_application_version_name},
          query_params: {'api-version' => @client.api_version},
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = @client.make_request_async(:delete, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200 || status_code == 202 || status_code == 204
          error_model = JSON.load(response_content)
          fail MsRestAzure::AzureOperationError.new(result.request, http_response, error_model)
        end

        result.request_id = http_response['x-ms-request-id'] unless http_response['x-ms-request-id'].nil?
        result.correlation_request_id = http_response['x-ms-correlation-request-id'] unless http_response['x-ms-correlation-request-id'].nil?
        result.client_request_id = http_response['x-ms-client-request-id'] unless http_response['x-ms-client-request-id'].nil?

        result
      end

      promise.execute
    end

    #
    # List gallery Application Versions in a gallery Application Definition.
    #
    # @param next_page_link [String] The NextLink from the previous successful call
    # to List operation.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [GalleryApplicationVersionList] operation results.
    #
    def list_by_gallery_application_next(next_page_link, custom_headers:nil)
      response = list_by_gallery_application_next_async(next_page_link, custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # List gallery Application Versions in a gallery Application Definition.
    #
    # @param next_page_link [String] The NextLink from the previous successful call
    # to List operation.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRestAzure::AzureOperationResponse] HTTP response information.
    #
    def list_by_gallery_application_next_with_http_info(next_page_link, custom_headers:nil)
      list_by_gallery_application_next_async(next_page_link, custom_headers:custom_headers).value!
    end

    #
    # List gallery Application Versions in a gallery Application Definition.
    #
    # @param next_page_link [String] The NextLink from the previous successful call
    # to List operation.
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def list_by_gallery_application_next_async(next_page_link, custom_headers:nil)
      fail ArgumentError, 'next_page_link is nil' if next_page_link.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json; charset=utf-8'

      # Set Headers
      request_headers['x-ms-client-request-id'] = SecureRandom.uuid
      request_headers['accept-language'] = @client.accept_language unless @client.accept_language.nil?
      path_template = '{nextLink}'

      request_url = @base_url || @client.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          skip_encoding_path_params: {'nextLink' => next_page_link},
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = @client.make_request_async(:get, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRestAzure::AzureOperationError.new(result.request, http_response, error_model)
        end

        result.request_id = http_response['x-ms-request-id'] unless http_response['x-ms-request-id'].nil?
        result.correlation_request_id = http_response['x-ms-correlation-request-id'] unless http_response['x-ms-correlation-request-id'].nil?
        result.client_request_id = http_response['x-ms-client-request-id'] unless http_response['x-ms-client-request-id'].nil?
        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = Azure::Compute::Mgmt::V2019_07_01::Models::GalleryApplicationVersionList.mapper()
            result.body = @client.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end

    #
    # List gallery Application Versions in a gallery Application Definition.
    #
    # @param resource_group_name [String] The name of the resource group.
    # @param gallery_name [String] The name of the Shared Application Gallery in
    # which the Application Definition resides.
    # @param gallery_application_name [String] The name of the Shared Application
    # Gallery Application Definition from which the Application Versions are to be
    # listed.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [GalleryApplicationVersionList] which provide lazy access to pages of
    # the response.
    #
    def list_by_gallery_application_as_lazy(resource_group_name, gallery_name, gallery_application_name, custom_headers:nil)
      response = list_by_gallery_application_async(resource_group_name, gallery_name, gallery_application_name, custom_headers:custom_headers).value!
      unless response.nil?
        page = response.body
        page.next_method = Proc.new do |next_page_link|
          list_by_gallery_application_next_async(next_page_link, custom_headers:custom_headers)
        end
        page
      end
    end

  end
end
