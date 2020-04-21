# frozen_string_literal: true

require_relative '../../../lib/xml/mapper.rb'

RSpec.describe Xml::Mapper do
  describe '#call' do
    subject { described_class.new(feed).call }

    # rubocop:disable Style/StringHashKeys
    let(:feed) do
      {
        'rss' => {
          'channel' => {
            'item' => [{
              'title' => 'AMD Ryzen Threadripper',
              'price' => '1800.0 USD',
              'link' => 'amd.com'
            }]
          }
        }
      }
    end
    # rubocop:enable Style/StringHashKeys

    it { is_expected.to eq([{ title: 'AMD Ryzen Threadripper', price: 1800.0, url: 'amd.com' }]) }
  end
end
