# frozen_string_literal: true

module Json
  class Mapper
    def initialize(feed)
      @feed = feed
    end

    def call
      @feed.map! do |record|
        {
          price: Float(record['price']),
          title: record['title'],
          url: record['full_url']
        }
      end
    end
  end
end
