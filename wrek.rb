require 'rubygems'
require 'nokogiri'
require 'open-uri'

#require 'lastfm'
#lastfm = Lastfm.new(api_key, api_secret)
#token = lastfm.auth.get_token
#lastfm.session = lastfm.auth.get_session(:token => token)['key']

#lastfm.track.love(:artist => 'Hujiko Pro', :track => 'acid acid 7riddim')
#lastfm.track.scrobble(:artist => 'Hujiko Pro', :track => 'acid acid 7riddim')
#lastfm.track.update_now_playing(:artist => 'Hujiko Pro', :track => 'acid acid 7riddim')




#Get a list of songs played on WREK today

url = "http://www.wrek.org/playlist/"
plays = []      #a set of hashes

page = Nokogiri::HTML (open(url))

#find the table with id=playlist, then for each tr tag,
#   grab each child node one at a time and 
page.css("#playlist").css("tr").each {|tr|
    play = {time:   tr.children[0].text, 
            title:  tr.children[1].text, 
            artist: tr.children[2].text, 
            album:  tr.children[3].text, 
            format: tr.children[4].text, 
            label:  tr.children[5].text, 
    }
    plays.push(play)
}

#of course, the first one was the column headers, so we want to drop it
plays = plays[1..-1]

#now print our array in a pretty format
for p in plays do
    puts "SONG:"
    p.each {|key,value| puts "\t#{key}:\t\t#{value}"}
end

