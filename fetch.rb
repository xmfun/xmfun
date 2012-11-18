require 'rubygems'
require 'net/http'
require 'curb'
require 'rexml/document'


$: << "#{File.dirname(__FILE__)}"
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__))))

require "XMcode.rb"

#Get XML

#url="http://www.xiami.com/song/playlist/id/7273826/type/3"
url="http://www.xiami.com/song/playlist/id/"+ARGV[0].to_s+"/type/3"
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
        mp3 = XMcode.decode(location)
        puts mp3
        
        #Curl comes
        #Curl::Easy.perform(mp3) do |curl| 
        #curl.headers["User-Agent"] = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5"
        #curl.verbose = true
        #curl.on_body {
        #    |d| f = File.open(title+"_"+artist+".mp3", 'wb') {|f| f.write d}
        #}
        #f = File.open(title+"_"+artist+".mp3", 'a') {|f| f.write curl.body_str}
        #end
        ##############
        c = Curl::Easy.new(mp3) do |curl| 
            curl.headers["User-Agent"] = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5"
            curl.verbose = true
            curl.on_body {
            |d| f = File.open(title+"_"+artist+".mp3", 'a') {|f| f.write d}
        }
        end
        c.perform
        
        
end



