# frozen_string_literal: true

require 'active_support/core_ext'
require 'uri/http'

module Varnish
  class Parser
    URL_BOUNDARIES_REGEXP = /#{Regexp.escape('GET ')}(.*?)#{Regexp.escape(' HTTP')}/m.freeze

    def initialize(log)
      @log = log
    end

    def call
      @log.split("\n").map!(&parse_line).compact
    end

    private

    def parse_line
      lambda do |line|
        url = line[URL_BOUNDARIES_REGEXP, 1]
        next if url.blank?

        uri = URI.parse(url)
        { host: uri.host, file: "#{uri.host}#{uri.path}" }
      end
    end
  end
end
