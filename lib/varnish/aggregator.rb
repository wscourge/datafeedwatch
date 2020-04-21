# frozen_string_literal: true

require 'active_support/core_ext'

module Varnish
  class Aggregator
    def initialize(log)
      @log = log
    end

    def call
      { hosts: aggregate_by(:host), files: aggregate_by(:file) }
    end

    private

    def aggregate_by(symbol)
      @log
        .group_by { |uri| uri[symbol] }
        .map { |key, value| [key, value.size] }
        .sort_by!(&:second)
        .reverse!
        .map!(&:first)[0..4]
    end
  end
end
