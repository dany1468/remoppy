require 'spec_helper'

describe Remoppy::CLI do
  let(:cli) { Remoppy::CLI.new }
  describe '#build_command' do
    subject { cli.send :build_command, command_name }
    [:run, :generator].each do |command|
      context "when #{command} given" do
        let(:command_name) { command }
        it { expect { subject }.not_to raise_error }
      end
    end
  end
end
