require 'spec_helper'
require_relative "../../ec2_bootstrapped_event_handler/ec2_bootstrapped_event_handler"

describe Wonga::Daemon::EC2BootstrappedEventHandler do
  let(:api_client) { instance_double('Wonga::Daemon::PantryApiClient').as_null_object }
  subject { Wonga::Daemon::EC2BootstrappedEventHandler.new(api_client, instance_double('Logger').as_null_object) }
  let(:message) { { "user_id" => 1 , "pantry_request_id" => 42, "instance_id" => "i-0123abcd" } }
  it_behaves_like "handler"

  it "updates Pantry using PantryApiClient" do
    expect(api_client).to receive(:send_put_request).with("/api/ec2_instances/42", { "user_id" => 1, "pantry_request_id" => 42, "instance_id" => "i-0123abcd", :event => :bootstrap, :bootstrapped => true })
    subject.handle_message(message)
  end
end
