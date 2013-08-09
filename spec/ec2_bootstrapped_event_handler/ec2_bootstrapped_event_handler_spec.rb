require 'spec_helper'
require_relative "../../ec2_bootstrapped_event_handler/ec2_bootstrapped_event_handler"

describe Wonga::Daemon::EC2BootstrappedEventHandler do
  let(:api_client) { instance_double('Wonga::Daemon::PantryApiClient').as_null_object }
  subject { Wonga::Daemon::EC2BootstrappedEventHandler.new(api_client, instance_double('Logger').as_null_object) }
  let(:message) { { 'pantry_request_id' => 42 } }
  it_behaves_like "handler"

  it "updates Pantry using PantryApiClient" do
    expect(api_client).to receive(:update_ec2_instance).with(42, { bootstrapped: true })
    subject.handle_message(message)
  end
end
