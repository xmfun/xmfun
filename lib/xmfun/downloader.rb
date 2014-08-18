# -*- encoding : utf-8 -*-

require 'open-uri'
require 'nokogiri'
require 'nori'
require 'parallel'
require 'ruby-progressbar'

module Xmfun
  class Downloader
    def self.download(url, dst)
      make_dst(dst)

      tracks = Nokogiri::XML(open(url, "Client-IP" => "220.181.111.168")).css("track")

      if tracks.size > 1
        download_collect(tracks)
      else
        download_song(tracks[0])
      end
    end

    private
    def self.make_dst(dst)
      if Dir.exist?(dst)
        Dir.chdir(dst)
      else
        Dir.mkdir(dst)
        Dir.chdir(dst)
      end
    end

    def self.make_progress_bar(size)
      ProgressBar.create( :title => "Progress",
                         :total => size,
                         :format => '%a %bᗧ%i %p%% %t',
                         :progress_mark  => ' ',
                         :remainder_mark => '･' )
    end

    def self.download_collect(collect)
      progress = make_progress_bar(collect.size)

      Parallel.map( collect, :in_threads => Parallel.processor_count, :finish => lambda { |item, i, result| progress.increment } ) do |track|

        track = Xmfun::Mp3::Track.new(Nori.new.parse(track.to_s)['track'])

        URI.parse(track.location).open do |f|
          File.open(track.file_name, 'w') { |mp3| mp3.write(f.read) }
        end

        Xmfun::Mp3::Mp3Tagger.tag(track)
      end
    end

    def self.download_song(song)
      track = Xmfun::Mp3::Track.new(Nori.new.parse(song.to_s)['track'])
      progress = nil

      content_length_lambda = lambda do |content_length|
        if content_length && 0 < content_length
          progress = make_progress_bar content_length
        end
      end

      progress_lambda = lambda { |size| progress.progress = size if progress }

      uri = URI.parse(track.location)

      uri.open( :content_length_proc => content_length_lambda,
               :progress_proc       => progress_lambda ) do |f|
        File.open(track.file_name, 'w') { |mp3| mp3.write(f.read) }
      end

      Xmfun::Mp3::Mp3Tagger.tag(track)
    end
  end
end
