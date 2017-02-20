require 'spec_helper'

describe Remoppy::Listener::Targettable do
  include described_class

  let(:target_participation_id) { 1234 }
  let(:target_participation_name) { 'target_participation_name' }
  let(:other_participation_id) { 5678 }
  let(:other_participation_name) { 'other_participation_name' }

  let(:target_participation) { instance_double('Participation', id: target_participation_id, name: target_participation_name) }
  let(:other_participation) { instance_double('Participation', id: other_participation_id, name: other_participation_name) }

  let(:event) { Remoppy::Event.new data.stringify_keys }

  before do
    allow(Remoppy::Remotty::Api::Room).to receive_message_chain(:rooms, :participations) {
      [target_participation, other_participation]
    }
  end

  describe '#restrict?' do
    subject { target?(event) }

    context 'when no restrict' do
      context 'target channel given' do
        let(:data) { {participation_id: target_participation_id} }
        it { is_expected.to be_truthy }
      end

      context 'other channel given' do
        let(:data) { {participation_id: other_participation_id} }
        it { is_expected.to be_truthy }
      end
    end

    context 'when single restrict' do
      context 'target channel given' do
        before { target.participation = target_participation_name }

        let(:data) { {participation_id: target_participation_id} }
        it { is_expected.to be_truthy }
      end

      context 'out of restrict channel given' do
        before { target.participation = target_participation_name }

        let(:data) { {participation_id: other_participation_id } }
        it { is_expected.to be_falsey }
      end
    end
  end
end
