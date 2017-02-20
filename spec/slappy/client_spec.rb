require 'spec_helper'

describe Remoppy::Client do
  let(:client) { Remoppy::Client.new }
  let(:realtime) { Remoppy::Remotty::Realtime::Client.new(url, nil, nil) }
  let(:url)      { nil }

  before do
    # There classes in slack-api (Stop connection for slack)
    allow_any_instance_of(Remoppy::Remotty::Api).to receive(:realtime).and_return(realtime)
    allow_any_instance_of(Remoppy::Remotty::Realtime::Client).to receive(:start).and_return(nil)
  end

  describe '#hear' do
    before { size.times { client.hear(regexp) { puts 'hear' } } }
    subject { client.instance_variable_get(:@callbacks)[:comment] }
    let(:regexp) { /test/ }
    let(:size)   { 3 }

    it 'should be registerd' do
      expect(subject.size).to eq size
    end
  end

  describe '#respond' do
    let(:participation_id) { 1234 }
    let(:comment_id) { 5678 }
    let(:pattern) { 'test' }
    let(:respond_message) { 'respond' }
    let(:botname) { 'slappy' }
    let(:event) { Remoppy::Event.new participation_id: participation_id, comment_id: comment_id }
    let(:comment) { double('comment') }

    before do
      Remoppy.configure {|config| config.robot.botname = botname }

      allow_any_instance_of(Remoppy::Listener::TextListener).to receive(:target?).and_return(true)
      allow(Remoppy::Remotty::Api::Comment).to receive(:find).with(hash_including(
        participations_id: participation_id, comment_id: comment_id
      )) { comment }

      allow(comment).to receive(:content) { event_text }

      client.respond(pattern) { print respond_message }
    end

    subject { client.instance_variable_get(:@callbacks)[:comment] }

    it 'should be registerd' do
      expect(subject.size).to eq 1
    end

    context 'when match pattern' do
      let(:event_text) { "#{botname} #{pattern}" }

      it 'should be callback call' do
        expect { subject.first.call(event) }.to output(respond_message).to_stdout
      end
    end

    context 'when not match pattern' do
      let(:event_text) { pattern }

      it 'should not be callback call' do
        expect { subject.first.call(event) }.to output('').to_stdout
      end
    end
  end

  describe '#goodnight' do
    subject { client.start }

    before do
      allow_any_instance_of(Remoppy::Remotty::Realtime::Client).to receive(:start).and_raise(StandardError)
      allow(STDERR).to receive(:puts).and_return(nil)
      client.goodnight { print 'goodnight' }
    end

    context 'when stop_with_error is true' do
      it { expect { subject }.to raise_error(SystemExit).and output('goodnight').to_stdout }
    end

    context 'when stop_with_error is false' do
      before { Remoppy.configure { |config| config.stop_with_error = false } }
      it { expect { subject }.not_to raise_error }
      it { expect { subject }.to output('goodnight').to_stdout }
    end
  end

  describe '#hello' do
    before { size.times { client.hello { puts 'hello' } } }
    subject { client.instance_variable_get(:@callbacks)[:hello] }
    let(:regexp) { /test/ }
    let(:size)   { 2 }

    it 'should be registerd' do
      expect(subject.size).to eq size
    end
  end

  describe '#start' do
    before do
      client.hello { 'hello' }
      client.hear(/hear/) { 'hear' }
    end

    subject { client.start }
    it { expect { subject }.not_to raise_error }
  end

  describe '#schedule' do
    subject { client.schedule(pattern, options) { nil } }
    let(:pattern) { '* * * * *' }
    let(:options) { Hash.new }
    it { expect { subject }.not_to raise_error }
  end

  describe '#config' do
    subject { client.send :config }
    it { is_expected.to be_instance_of Remoppy::Configuration }
  end
end
