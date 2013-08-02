require_relative "../../ec2_bootstrapped_event_handler/ec2_bootstrapped_event_handler"
require 'spec_helper'

describe Daemons::EC2BootstrappedEventHandler do
  subject { Daemons::EC2BootstrappedEventHandler.new() }

  let(:good_message_hash) {
    {
      "Message"=>{
        "request_id"=>1,
        "instance_id"=>"i-f4819cb9"
      }
    }
  }
  let(:good_message_json) { good_message_hash.to_json }
  let(:good_payload_json) { good_message_json["Message"].to_json }
  let(:url) { "some_url" }
  let(:api_key) { "some_api_key"}
  let(:timeout) { 10 }

  describe "#update_instance_booted_status" do
    it "Updates the instance boot status from a good message" do
      expect{subject.update_instance_booted_status(url,good_payload_json,api_key,timeout)}.not_to be false
    end
  end

  describe "#handle_message" do
    it "Receives a correct SQS message and proceeds" do
      expect{subject.handle_message(good_message_json)}.not_to be false
    end
  end

end
