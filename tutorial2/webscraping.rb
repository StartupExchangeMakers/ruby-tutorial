require 'rubygems'
require 'nokogiri'
require 'open-uri'



# save the location of the weather in Atlanta
weather_url = "http://www.weather.com/weather/today/Atlanta+GA+USGA0028:1:US"


#makes the class on the left side is a class. 

weather_page = Nokogiri::HTML (open(weather_url))

#search the weather page only for the temperature page
temperature = ((weather_page.css(".wx-temperature")).first).text

# tell user the temperature
puts "It is currently " + temperature + " at Georgia Tech."
