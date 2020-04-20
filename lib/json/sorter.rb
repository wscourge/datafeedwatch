# frozen_string_literal: true

module Json
  class Sorter
    def initialize(feed)
      @feed = feed
    end

    def call
      @feed.sort_by! { |record| record[:price] }
    end
  end
end
