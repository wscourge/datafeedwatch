# frozen_string_literal: true

module Xml
  class Mapper
    def initialize(feed)
      @feed = feed
    end

    def call
      @feed['rss']['channel']['item'].map! do |record|
        {
          price: Float(record['price'].split(' ').first),
          title: record['title'],
          url: record['link']
        }
      end
    end
  end
end
