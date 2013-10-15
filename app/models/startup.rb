require 'net/http'
require 'uri'

class Startup < ActiveRecord::Base
  attr_accessible :name, :logo_url, :product_desc, :high_concept, :company_url, :location

  def self.create_by_angel_data(data)
    create(
      :name => data['name'],
      :logo_url => data['logo_url'],
      :location => get_location(data['locations'][0]['name']),
      :product_desc => data['product_desc'],
      :high_concept => data['high_concept'],
      :company_url => formatted_url(data['company_url'])
    )
  end

  def self.make_angel_request(url)
    JSON.parse(Net::HTTP.get(URI.parse("http://api.angel.co/1/startups/search.json?domain=#{url}")))
  end

  def self.formatted_url(url)
    uri = URI(url).host
    uri ? uri.gsub(/^www./,'').downcase : url.downcase
  end

  def self.get_location(city)
    data = JSON.parse(Net::HTTP.get(URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{city.split(' ').join('+')}&sensor=true")))
    data['results'][0]['formatted_address']
  end
end
