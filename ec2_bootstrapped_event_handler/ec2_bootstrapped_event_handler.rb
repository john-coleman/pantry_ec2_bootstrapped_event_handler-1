module Wonga
  module Daemon
    class EC2BootstrappedEventHandler
      def initialize(api_client, logger)
        @api_client = api_client
        @logger = logger
      end

      def handle_message(message)
        @api_client.send_put_request("/api/ec2_instances/#{message["pantry_request_id"]}", { bootstrapped: true})
      end
    end
  end
end

