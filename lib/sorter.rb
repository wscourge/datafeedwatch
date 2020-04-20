# frozen_string_literal: true

class Sorter
  def initialize(feed)
    @feed = feed
  end

  def call
    @feed.sort_by! { |record| record[:price] }
  end
end
