# frozen_string_literal: true

require 'net/http'
require 'active_support/core_ext'
require_relative './mapper'
require_relative '../sorter'

module Xml
  class Main
    def initialize(url)
      @url = url
    end

    def print
      download
      parse
      map
      sort
    end

    private

    def download
      @xml = Net::HTTP.get(URI(@url))
    end

    def parse
      @xml = Hash.from_xml(@xml)
    end

    def map
      @xml = Xml::Mapper.new(@xml).call
    end

    def sort
      @xml = Sorter.new(@xml).call
    end
  end
end
