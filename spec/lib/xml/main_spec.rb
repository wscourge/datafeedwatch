# frozen_string_literal: true

require 'net/http'
require_relative '../../../lib/xml/main.rb'
require_relative '../../../lib/xml/mapper.rb'
require_relative '../../../lib/sorter.rb'

RSpec.describe Xml::Main do
  describe '#print' do
    subject(:call) { described_class.new(url).print }

    let(:url) { 'http://example.com' }
    let(:net_http_class) { class_double(Net::HTTP).as_stubbed_const }
    let(:uri_class) { class_double(URI).as_stubbed_const }
    let(:mapper_class) { class_double(Xml::Mapper).as_stubbed_const }
    let(:mapper_instance) { instance_double(Xml::Mapper) }
    let(:sorter_class) { class_double(Sorter).as_stubbed_const }
    let(:sorter_instance) { instance_double(Sorter) }

    before do
      allow(net_http_class).to receive(:get)
      allow(mapper_class).to receive(:new).and_return(mapper_instance)
      allow(mapper_instance).to receive(:call)
      allow(sorter_class).to receive(:new).and_return(sorter_instance)
      allow(sorter_instance).to receive(:call)
      call
    end

    it 'downloads xml' do
      expect(net_http_class).to have_received(:get).once
    end

    it 'maps xml' do
      expect(mapper_class).to have_received(:new).once
      expect(mapper_instance).to have_received(:call).once
    end

    it 'sorts array' do
      expect(sorter_class).to have_received(:new).once
      expect(sorter_instance).to have_received(:call).once
    end
  end
end
