# frozen_string_literal: true

require_relative './lib/varnish/main'
require_relative './lib/xml/main'
require_relative './lib/json/main'

class Main
  def initialize(varnish_path:, xml_url:, json_ftp:)
    @varnish = Varnish::Main.new(varnish_path)
    @xml = Xml::Main.new(xml_url)
    @json = Json::Main.new(json_ftp)
  end

  def print
    @varnish.print
    @xml.print
    @json.print
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
