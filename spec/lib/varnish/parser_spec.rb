# frozen_string_literal: true

require_relative '../../../lib/varnish/parser.rb'

RSpec.describe Varnish::Parser do
  describe '#call' do
    subject { described_class.new(string).call }

    let(:string) do
      "
      irrelevant GET https://example.com/dummy.php?a=1&b=2#title HTTP/1.1 nope\n
      dont think so GET http://elpmaxe.ru/ymmud.asp?c=1&d=2#content HTTP/1.0 not rly\n
      "
    end
    let(:expected) do
      [
        { host: 'example.com', file: 'example.com/dummy.php' },
        { host: 'elpmaxe.ru', file: 'elpmaxe.ru/ymmud.asp' }
      ]
    end

    it { is_expected.to eq(expected) }
  end
end
