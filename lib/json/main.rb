# frozen_string_literal: true

require 'json'
require_relative './downloader'
require_relative './mapper'
require_relative '../sorter'

module Json
  class Main
    def initialize(username:, password:, domain:, filename:)
      @username = username
      @password = password
      @domain = domain
      @filename = filename
    end

    def print
      download
      parse
      map
      sort
      cleanup
      @parsed
    end

    private

    def download
      Json::Downloader.new(
        username: @username,
        password: @password,
        domain: @domain,
        filename: @filename
      ).call
    end

    def parse
      @parsed = JSON.parse(File.read(Json::Downloader::FILE_PATH))
    end

    def map
      @parsed = Json::Mapper.new(@parsed).call
    end

    def sort
      @parsed = Sorter.new(@parsed).call
    end

    def cleanup
      File.delete(Json::Downloader::FILE_PATH) if File.exist?(Json::Downloader::FILE_PATH)
    end
  end
end
