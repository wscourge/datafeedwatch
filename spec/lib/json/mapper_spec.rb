# frozen_string_literal: true

require_relative '../../../lib/json/mapper.rb'

RSpec.describe Json::Mapper do
  describe '#call' do
    subject { described_class.new(feed).call }

    # rubocop:disable Style/StringHashKeys
    let(:feed) do
      [{
        'title' => 'AMD Ryzen Threadripper',
        'price' => '1800',
        'full_url' => 'amd.com'
      }]
    end
    # rubocop:enable Style/StringHashKeys

    it { is_expected.to eq([{ title: 'AMD Ryzen Threadripper', price: 1800.0, url: 'amd.com' }]) }
  end
end
