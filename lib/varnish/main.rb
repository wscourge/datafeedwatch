# frozen_string_literal: true

require_relative './parser'
require_relative './aggregator'

module Varnish
  class Main
    def initialize(path)
      @path = path
    end

    def print
      read
      parse
      group
    end

    private

    def read
      @log = File.read(@path)
    end

    def parse
      @log = Varnish::Parser.new(@log).call
    end

    def group
      @log = Varnish::Aggregator.new(@log).call
    end
  end
end
