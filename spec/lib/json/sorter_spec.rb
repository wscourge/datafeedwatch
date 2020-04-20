# frozen_string_literal: true

require_relative '../../../lib/json/sorter.rb'

RSpec.describe Json::Sorter do
  describe '#call' do
    subject { described_class.new(feed).call }

    let(:feed) do
      [
        { price: 1800.1 },
        { price: 1799.99 },
        { price: 1800.0 }
      ]
    end

    it { is_expected.to eq([{ price: 1799.99 }, { price: 1800.0 }, { price: 1800.1 }]) }
  end
end
