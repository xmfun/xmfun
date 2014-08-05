#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'
require 'clap'
require 'mp3info'
require 'pry'
require 'parallel'
require 'ruby-progressbar'
require_relative "XMcode"

HELP = <<-HELP
Usage: ruby xmfun.rb
  -c cid  -- download a music collect
  -s sid  -- download a single song
  -d path -- path to save your music
  -v      -- show version
  -h      -- show help message

Example:  Download Collect with ID 10181268 and save to current path)
          ./xmfun.rb -c 10181268 -d .
HELP

url = ''
dst = '.'

def download(url, dst)

  if Dir.exist?(dst)
    Dir.chdir(dst)
  else
    Dir.mkdir(dst)
    Dir.chdir(dst)
  end

  f = Nokogiri::XML(open(url, "Client-IP" => "220.181.111.168"))
  progress = ProgressBar.create(:title => "The Progress", :total => f.css("track").size )
  Parallel.map(f.css("track"), :finish => lambda { |item, i, result| progress.increment }) do |track|
    album     = track.css('album_name').text
    artist    = track.css('artist').text
    lyric     = track.css('lyric').text
    title     = track.css('title').text
    location  = track.css('location').text
    album_pic = track.css('album_pic').text
    mp3 = XMcode.decode(location)
    uri = URI.parse(mp3)
    uri.open(:content_length_proc => lambda { |content_length| content_length },
             :progress_proc => lambda {|size| }) do |f|
      File.open("#{title}_#{artist}.mp3", 'w') { |mp3| mp3.write(f.read) }
    end
    # add mp3 meta info
    Mp3Info.open "#{title}_#{artist}.mp3" do |m|
      m.tag.artist = artist
      m.tag.title  = title
      m.tag.album  = album

      m.tag2.remove_pictures
      m.tag2.add_picture(open(album_pic).read)
    end
  end
end

Clap.run ARGV,
  "-c" => lambda { |collect_id| url = "http://www.xiami.com/song/playlist/id/#{collect_id}/type/3" },
  "-s" => lambda { |song_id| url = "http://www.xiami.com/song/playlist/id/#{song_id}/object_name/default/object_id/0" },
  "-d" => lambda { |d| dst = d },
  "-v" => lambda { puts "0.0.1" },
  "-h" => lambda { puts HELP }

download(url, dst)
