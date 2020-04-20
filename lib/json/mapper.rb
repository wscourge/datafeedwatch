# frozen_string_literal: true

module Json
  class Mapper
    def initialize(feed)
      @feed = feed
    end

    def call
      @feed.map! do |record|
        {
          title: record['title'],
          url: record['full_url'],
          price: Float(record['price'])
        }
      end
    end
  end
end
