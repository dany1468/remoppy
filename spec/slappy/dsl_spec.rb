require 'spec_helper'
require 'remoppy/dsl'

describe Remoppy::DSL do
  describe '.delegate' do
    before { target.extend Remoppy::DSL }
    let(:target) { Object.new }
    subject { target }

    context 'when delegated method' do
      it { expect(target.respond_to? :hello).to be_truthy }
      it { expect { target.hello }.not_to raise_error }
    end

    context 'when not delegated method' do
      subject { target.respond_to? :undefined_method }
      it { is_expected.to be_falsy }
    end

    context 'when add receiver call' do
      subject { Remoppy }
      it { expect { subject.hello }.not_to raise_error }
      it { expect(subject.respond_to? :hello).to be_truthy }
    end
  end
end
