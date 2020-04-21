# frozen_string_literal: true

require_relative '../../../lib/varnish/main.rb'
require_relative '../../../lib/varnish/aggregator.rb'
require_relative '../../../lib/varnish/parser.rb'

RSpec.describe Varnish::Main do
  describe '#print' do
    subject(:call) { described_class.new(path).print }

    let(:path) { '/path/to/varnish.log' }
    let(:file_class) { class_double(File).as_stubbed_const }
    let(:parser_class) { class_double(Varnish::Parser).as_stubbed_const }
    let(:parser_instance) { instance_double(Varnish::Parser) }
    let(:aggregator_class) { class_double(Varnish::Aggregator).as_stubbed_const }
    let(:aggregator_instance) { instance_double(Varnish::Aggregator) }

    before do
      allow(file_class).to receive(:read)
      allow(parser_class).to receive(:new).and_return(parser_instance)
      allow(parser_instance).to receive(:call)
      allow(aggregator_class).to receive(:new).and_return(aggregator_instance)
      allow(aggregator_instance).to receive(:call)
      call
    end

    it 'reads log file' do
      expect(file_class).to have_received(:read).once
    end

    it 'parses log file' do
      expect(parser_class).to have_received(:new).once
      expect(parser_instance).to have_received(:call).once
    end

    it 'aggregates logs' do
      expect(aggregator_class).to have_received(:new).once
      expect(aggregator_instance).to have_received(:call).once
    end
  end
end
