require 'spec_helper'

describe Remoppy do
  describe '.configuration' do
    context 'when block not given' do
      subject { Remoppy.configure }
      it { is_expected.to be_instance_of Remoppy::Configuration }
    end

    context 'when block given' do
      before do
        Remoppy.configure do |config|
          config.token = token
        end
      end
      subject { Remoppy.configuration }
      let(:token) { 'slappy' }

      it { expect(Remoppy.configuration.token).to eq token }
    end
  end

  describe '.method_missing' do
    context 'when client method call' do
      subject { Remoppy.hello { puts 'hello' } }
      it { expect { subject }.not_to raise_error }
    end

    context 'when undefined method call' do
      subject { Remoppy.undefined_method { puts 'hello' } }
      it { expect { subject }.to raise_error NoMethodError }
    end
  end

  describe '.respond_to?' do
    context 'when client method call' do
      subject { Remoppy.respond_to? :hello }
      it { is_expected.to be_truthy }
    end

    context 'when undefined method call' do
      subject { Remoppy.respond_to? :undefined_method }
      it { is_expected.to be_falsy }
    end
  end

  describe '.logger' do
    subject { Remoppy.logger }
    let(:logger) { Logger }
    it { is_expected.to be_instance_of logger }
  end
end
