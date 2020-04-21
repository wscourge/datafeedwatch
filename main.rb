# frozen_string_literal: true

require 'tty-table'
require_relative './lib/varnish/main'
require_relative './lib/xml/main'
require_relative './lib/json/main'

class Main
  PRODUCT_HEADERS = %w[Price Title URL].freeze

  def initialize(varnish_path:, xml_url:, json_ftp:)
    @varnish = Varnish::Main.new(varnish_path).print
    @xml = Xml::Main.new(xml_url).print
    @json = Json::Main.new(**json_ftp).print
  end

  def print
    print_varnish
    print_xml
    print_json
  end

  private

  def print_varnish
    print_logs(:hosts)
    print_logs(:files)
  end

  def print_xml
    puts('XML products')
    print_products(@xml)
  end

  def print_json
    puts('JSON products')
    print_products(@json)
  end

  def print_products(hash)
    puts(TTY::Table.new(header: PRODUCT_HEADERS, rows: hash.map(&:values)).render(:unicode))
  end

  def print_logs(key)
    puts(TTY::Table.new(header: ["Varnish #{key}"], rows: @varnish[key].map { |array| [array] }).render(:unicode))
  end
end

Main.new(
  varnish_path: './varnish.log',
  xml_url: 'https://feeds.datafeedwatch.com/8946/87b1895fcf293e81cc27af931aa0c3c6d6b580d6.xml',
  json_ftp: {
    # 'ftp://dfw_test:RidetKoj0@ftp.datafeedwatch.com/feed.json'
    username: 'dfw_test',
    password: 'RidetKoj0',
    domain: 'ftp.datafeedwatch.com',
    filename: 'feed.json'
  }
).print
