# frozen_string_literal: true

require_relative '../../../lib/varnish/aggregator.rb'

RSpec.describe Varnish::Aggregator do
  describe '#call' do
    subject { described_class.new(logs).call }

    let(:first) { { host: 'first.com', file: 'first.com/1.rb' } }
    let(:second) { { host: 'second.com', file: 'second.com/2.rb' } }
    let(:third) { { host: 'third.com', file: 'third.com/3.rb' } }
    let(:fourth) { { host: 'fourth.com', file: 'fourth.com/4.rb' } }
    let(:fifth) { { host: 'fifth.com', file: 'fifth.com/5.rb' } }
    let(:sixth) { { host: 'sixth.com', file: 'sixth.com/6.rb' } }

    let(:logs) do
      [
        first,
        first,
        first,
        first,
        first,
        first,
        second,
        second,
        second,
        second,
        second,
        third,
        third,
        third,
        third,
        fourth,
        fourth,
        fourth,
        fifth,
        fifth,
        sixth
      ]
    end
    let(:expected) do
      {
        hosts: ['first.com', 'second.com', 'third.com', 'fourth.com', 'fifth.com'],
        files: ['first.com/1.rb', 'second.com/2.rb', 'third.com/3.rb', 'fourth.com/4.rb', 'fifth.com/5.rb']
      }
    end

    it { is_expected.to eq(expected) }
  end
end
