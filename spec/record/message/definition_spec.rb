require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Fit::Record::Message::Definition do
  context "given a sample definition message" do
    subject do
      described_class.read support_file('samples/record/message/definition')
    end

    its(:architecture) { should == 0 }
    its(:global_message_number) { should == 0 }
    its(:field_count) { should == 6 }

    it { should have(subject.field_count).fields }
  end
end