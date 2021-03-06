# Datafeedwatch.com recruitment task

CLI program that:

- reads the file from the provided varnish.log file
- read the XML file from the https://feeds.datafeedwatch.com/8946/87b1895fcf293e81cc27af931aa0c3c6d6b580d6.xml
- read the JSON file from ftp://dfw_test:RidetKoj0@ftp.datafeedwatch.com/feed.json

## Varnish log results

Should be grouped and display the five hostname with the most traffic and display the five files with the most requests.

## XML file from the URL

Should display a list of products sorted by "g: price". The sorted list should display price, title and product link.

## JSON file from FTP

Should display a list of products sorted by the "price" field similarly to the previous item. The sorted list should
display the price, title and product link.

## How to run it?

To launch the script, you need to:

1. Clone this repository
2. Install the **2.7.1** Ruby version
3. Run `bundle install`
4. Run `ruby main.rb`

Enjoy.

## How to run tests?

To run the test suite, run `bundle exec rspec`.
