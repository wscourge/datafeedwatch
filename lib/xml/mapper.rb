# frozen_string_literal: true

module Xml
  class Mapper
    def initialize(feed)
      @feed = feed
    end

    def call
      @feed['rss']['channel']['item'].map! do |record|
        {
          title: record['title'],
          url: record['link'],
          price: Float(record['price'].split(' ').first)
        }
      end
    end
  end
end
