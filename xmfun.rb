#!/usr/bin/ruby
require 'open-uri'
require 'nokogiri'
require 'clap'
require_relative "XMcode"


#if ARGV[0].to_i == 0
#url="http://www.xiami.com/song/playlist/id/"+ARGV[2].to_s+"/type/3"
#else
#url="http://www.xiami.com/song/playlist/id/"+ARGV[2].to_s+"/object_name/default/object_id/0"
#end
HELP = <<-HELP
Usage: ruby xmfun.rb
  -c cid  -- download a music collect
  -s sid  -- download a single song
  -d path -- path to save your music
  -v      -- show version
  -h      -- show help message

Example:  Download Collect with ID 10181268 and save to current path)
          ruby xmfun.rb -c 10181268 -d .
HELP

url = ''
dst = '.'

Clap.run ARGV,
  "-c" => lambda { |collect_id| url = "http://www.xiami.com/song/playlist/id/#{collect_id}/type/3" },
  "-s" => lambda { |song_id| url = "http://www.xiami.com/song/playlist/id/#{song_id}/object_name/default/object_id/0" },
  "-d" => lambda { |d| dst = d },
  "-v" => lambda { puts "0.0.1" },
  "-h" => lambda { puts HELP }

if Dir.exist?(dst)
  Dir.chdir(dst)
else
  Dir.mkdir(dst)
  Dir.chdir(dst)
end

puts url

f = Nokogiri::XML(open(url, "Client-IP" => "220.181.111.168"))

f.css("track").each do |track|
  album    = track.css('album_name').text
  artist   = track.css('artist').text
  lyric    = track.css('lyric').text
  title    = track.css('title').text
  location = track.css('location').text

  mp3 = XMcode.decode(location)

  uri = URI.parse(mp3)
  uri.open(:content_length_proc => lambda { |content_length| puts content_length },
           :progress_proc => lambda {|size| }) do |f|
    File.open("#{title}_#{artist}.mp3", 'w') { |mp3| mp3.write(f.read) }
  end
end
