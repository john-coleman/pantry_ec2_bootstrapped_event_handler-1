require 'timeout'
require 'json'
require 'rest_client'

module Wonga
  module Daemon
    class EC2BootstrappedEventHandler
      def initialize(api_client, logger)
        @api_client = api_client
        @logger = logger
      end

      def handle_message(message)
        @api_client.update_ec2_instance(message['pantry_request_id'], {:bootstrapped => true})
      end
    end

    class PantryApiClient
      def initialize(url, api_key, logger, timeout = 300)
        @resource = RestClient::Resource.new(url, timeout: timeout, headers: { :accept => :json, :content_type => :json, :'x-auth-token' => api_key })
        RestClient.log = logger
      end

      def update_ec2_instance(request_id, params)
        params = params.to_json if params.is_a? Hash
        @resource["/aws/ec2_instances/#{request_id}"].put params
      end
    end
  end
end

