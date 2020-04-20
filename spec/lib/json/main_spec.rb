# frozen_string_literal: true

require 'json'
require_relative '../../../lib/json/main.rb'
require_relative '../../../lib/json/downloader.rb'
require_relative '../../../lib/json/mapper.rb'
require_relative '../../../lib/sorter.rb'

RSpec.describe Json::Main do
  describe '#print' do
    subject(:call) do
      described_class.new(
        username: username,
        password: password,
        domain: domain,
        filename: filename
      ).print
    end

    let(:username) { 'admin' }
    let(:password) { 'secret' }
    let(:domain) { 'example.com' }
    let(:filename) { 'coolstuff.json' }
    let(:json_class) { class_double(JSON).as_stubbed_const }
    let(:file_class) { class_double(File).as_stubbed_const }
    let(:downloader_class) { class_double(Json::Downloader).as_stubbed_const(transfer_nested_constants: true) }
    let(:downloader_instance) { instance_double(Json::Downloader) }
    let(:mapper_class) { class_double(Json::Mapper).as_stubbed_const }
    let(:mapper_instance) { instance_double(Json::Mapper) }
    let(:sorter_class) { class_double(Sorter).as_stubbed_const }
    let(:sorter_instance) { instance_double(Sorter) }

    before do
      allow(file_class).to receive(:read)
      allow(file_class).to receive(:delete)
      allow(file_class).to receive(:exist?).and_return(true)
      allow(json_class).to receive(:parse)
      allow(downloader_class).to receive(:new).and_return(downloader_instance)
      allow(downloader_instance).to receive(:call)
      allow(mapper_class).to receive(:new).and_return(mapper_instance)
      allow(mapper_instance).to receive(:call)
      allow(sorter_class).to receive(:new).and_return(sorter_instance)
      allow(sorter_instance).to receive(:call)
      call
    end

    it 'downloads file' do
      expect(downloader_class).to have_received(:new).once
      expect(downloader_instance).to have_received(:call).once
    end

    it 'parses file' do
      expect(file_class).to have_received(:read).once
      expect(json_class).to have_received(:parse).once
    end

    it 'maps json' do
      expect(mapper_class).to have_received(:new).once
      expect(mapper_instance).to have_received(:call).once
    end

    it 'sorts array' do
      expect(sorter_class).to have_received(:new).once
      expect(sorter_instance).to have_received(:call).once
    end

    it 'cleans up' do
      expect(file_class).to have_received(:exist?).once
      expect(file_class).to have_received(:delete).once
    end
  end
end
