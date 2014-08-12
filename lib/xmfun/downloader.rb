require 'open-uri'
require 'nokogiri'
require 'clap'
require 'mp3info'
require 'parallel'
require 'ruby-progressbar'
require 'xmfun/decoder'

module Xmfun
  class Downloader
    def self.download(url, dst)

      if Dir.exist?(dst)
        Dir.chdir(dst)
      else
        Dir.mkdir(dst)
        Dir.chdir(dst)
      end

      f = Nokogiri::XML(open(url, "Client-IP" => "220.181.111.168"))
      progress = ProgressBar.create( :title => "Progress",
                                     :total => f.css("track").size,
                                     :format => '%a %bᗧ%i %p%% %t',
                                     :progress_mark  => ' ',
                                     :remainder_mark => '･'
                                   )
      Parallel.map( f.css("track"), :in_threads => Parallel.processor_count, :finish => lambda { |item, i, result| progress.increment } ) do |track|
        album     = track.css('album_name').text
        artist    = track.css('artist').text
        lyric     = track.css('lyric').text
        title     = track.css('title').text
        location  = track.css('location').text
        album_pic = track.css('album_pic').text
        mp3 = Decoder.decode(location)

        URI.parse(mp3).open do |f|
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

  end
end
