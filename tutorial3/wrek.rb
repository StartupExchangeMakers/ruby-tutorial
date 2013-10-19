require 'rubygems'
require 'nokogiri'
require 'open-uri'


#Get a list of songs played on WREK today

url = "http://www.wrek.org/playlist/"
plays = []      #a set of hashes

page = Nokogiri::HTML (open(url))

#find the table with id=playlist, then for each tr tag,
#   grab each child node one at a time and store it to
#   a hash, and put that hash in the plays array

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
