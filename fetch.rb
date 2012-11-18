require 'rubygems'
require 'net/http'
require 'curb'
require 'xmlsimple'
require 'rexml/document'
require "XMcode"

#Get XML

url="http://www.xiami.com/song/playlist/id/10181268/type/3"
xml = Net::HTTP.get_response(URI.parse(url)).body


#data = XmlSimple.xml_in(xml,"forcearray" => false)
xmldoc = REXML::Document.new(xml)

#xmldoc.elements.each("playlist/trackList/track/title"){
#	|e| puts "Title : " + e.text
#}

xmldoc.elements.each("playlist/trackList/track") do |track|
        title    = track.elements['title'].text
        artist   = track.elements['artist'].text
        location = track.elements['location'].text
        #puts title+" "+artist+":"+location
        print title+" "
        puts XMcode.decode(location)
end




