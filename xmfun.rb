require 'rubygems'
require 'net/http'
require 'curb'
require 'rexml/document'


$: << "#{File.dirname(__FILE__)}"
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__))))

require "XMcode.rb"

# quit unless our script gets two command line arguments
unless ARGV.length > 1
	puts "-----------------------------------------------------------------"
	puts "Usage: ruby xmfun.rb $typeID [$Lyric] $ID\n"
	puts "typeID: "
	puts "       0: Download Music Collect"
	puts "       1: Download Single Song"
	puts "ID:"
	puts "		 Collect ID or Song ID"
	puts "Lyric: "
	puts "		 0: Only download music"
	puts "		 1: Download music with lyric"
	puts "Example: ruby xmfun.rb 0 0 10181268 (Download Collect with ID 10181268 without lyrics)"
  	puts "-----------------------------------------------------------------"
	exit
end

#Get XML
if ARGV[0].to_i == 0
	url="http://www.xiami.com/song/playlist/id/"+ARGV[2].to_s+"/type/3"
else
	url="http://www.xiami.com/song/playlist/id/"+ARGV[2].to_s+"/object_name/default/object_id/0"
end

xml = Net::HTTP.get_response(URI.parse(url)).body


xmldoc = REXML::Document.new(xml)

xmldoc.elements.each("playlist/trackList/track") do |track|
        title    = track.elements['title'].text
		album    = track.elements['album_name'].text
        artist   = track.elements['artist'].text
        location = track.elements['location'].text
		lyric	 = track.elements['lyric'].text
        print title+" "
        mp3 = XMcode.decode(location)
        
        c = Curl::Easy.new(mp3) do |curl| 
            curl.headers["User-Agent"] = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5"
            curl.verbose = false
            curl.on_body {
            |d| f = File.open(title+"_"+artist+".mp3", 'a') {|f| f.write d}
        }
        end
        c.perform
        
if ARGV[1].to_i==1
		c = Curl::Easy.new(lyric) do |curl|
		curl.headers["User-Agent"] = "Mozilla/5.0 (iPhone; U; CPU iPhone     OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Ver    sion/5.0.2 Mobile/8J2 Safari/6533.18.5"
 		curl.verbose = false
 		curl.on_body {
 			|d| f = File.open(title+"_"+artist+".lrc", 'a') {|f| f.write d}
 		}
		end
 		c.perform
end
        
end

