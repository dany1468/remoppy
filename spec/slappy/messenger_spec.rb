require 'spec_helper'

describe Remoppy::Messenger do
  describe '#message' do
    let(:target_participation_id) { 1234 }
    let(:target_participation_name) { 'target_participation_name' }
    let(:target_participation) { instance_double('Participation', id: target_participation_id, name: target_participation_name) }

    before do
      allow(Remoppy::Remotty::Api::Room).to receive_message_chain(:rooms, :participations) { [target_participation] }
    end

    let(:messenger) { Remoppy::Messenger.new(participation: participation, text: text, all: to_all) }
    let(:participation) { target_participation_name }
    let(:text) { 'comment' }
    let(:to_all) { false }

    describe 'participation について' do
      context 'participation が指定されていないとき' do
        let(:participation) { nil }

        specify do
          expect { messenger.message }.to raise_error(Remoppy::Messenger::MissingParticipationException)
        end
      end

      context 'participation が指定されているとき' do
        specify do
          expect(Remoppy::Remotty::Api::Comment).to receive(:create).with(
            participations_id: target_participation_id,
            comment: {
              content: text,
              all: to_all
            }
          )

          messenger.message
        end
      end
    end
  end
end
