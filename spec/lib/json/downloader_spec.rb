# frozen_string_literal: true

require 'net/ftp'
require_relative '../../../lib/json/downloader.rb'

RSpec.describe Json::Downloader do
  describe '#call' do
    subject(:call) do
      described_class.new(
        username: username,
        password: password,
        domain: domain,
        filename: filename
      ).call
    end

    let(:username) { 'admin' }
    let(:password) { 'secret' }
    let(:domain) { 'example.com' }
    let(:filename) { 'coolstuff.json' }
    let(:ftp_class) { class_double(Net::FTP).as_stubbed_const }
    let(:ftp_instance) { instance_double(Net::FTP) }

    before do
      allow(ftp_class).to receive(:new).and_return(ftp_instance)
      allow(ftp_instance).to receive(:login)
      allow(ftp_instance).to receive(:getbinaryfile)
      allow(ftp_instance).to receive(:close)
    end

    it 'interacts with Net::FTP' do
      call
      expect(ftp_class).to have_received(:new).with(domain).once
      expect(ftp_instance).to have_received(:login).with(username, password).once
      expect(ftp_instance).to have_received(:getbinaryfile).with(filename, './tmp/feed.json').once
      expect(ftp_instance).to have_received(:close).once
    end
  end
end
