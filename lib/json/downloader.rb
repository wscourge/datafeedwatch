# frozen_string_literal: true

require 'net/ftp'

module Json
  class Downloader
    FILE_PATH = './tmp/feed.json'

    def initialize(username:, password:, domain:, filename:)
      @username = username
      @password = password
      @domain = domain
      @filename = filename
    end

    def call
      ftp = Net::FTP.new(@domain)
      ftp.login(@username, @password)
      ftp.getbinaryfile(@filename, FILE_PATH)
      ftp.close
    end
  end
end
