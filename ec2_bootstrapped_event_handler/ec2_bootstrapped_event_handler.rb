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
  end
end

