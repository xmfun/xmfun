# -*- encoding : utf-8 -*-

require 'open-uri'
require 'nokogiri'
require 'nori'
require 'clap'
require 'parallel'
require 'ruby-progressbar'


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

      tracks = f.css("track")

      if tracks.size > 1
        # progress
        progress = ProgressBar.create( :title => "Progress",
                                      :total => tracks.size,
                                      :format => '%a %bᗧ%i %p%% %t',
                                      :progress_mark  => ' ',
                                      :remainder_mark => '･'
                                     )

        #download collect
        Parallel.map( tracks, :in_threads => Parallel.processor_count, :finish => lambda { |item, i, result| progress.increment } ) do |track|

          track = Xmfun::Mp3::Track.new(Nori.new.parse(track.to_s)['track'])

          URI.parse(track.location).open do |f|
            File.open(track.file_name, 'w') { |mp3| mp3.write(f.read) }
          end

          # add mp3 meta info
          Xmfun::Mp3::Mp3Tagger.tag(track)
        end
      else
        #download single sone
        song = tracks[0]
        track = Xmfun::Mp3::Track.new(Nori.new.parse(song.to_s)['track'])

        uri = URI.parse(track.location)

        progress = nil

        uri.open(:content_length_proc => lambda do |content_length|
          if content_length && 0 < content_length
            progress = ProgressBar.create( :title => "Progress",
                                          :total => content_length,
                                          :format => '%a %bᗧ%i %p%% %t',
                                          :progress_mark  => ' ',
                                          :remainder_mark => '･')
          end
        end,
        :progress_proc => lambda {|size| progress.progress = size if progress}) do |f|
          File.open(track.file_name, 'w') { |mp3| mp3.write(f.read) }
        end

        # add mp3 meta info
        Xmfun::Mp3::Mp3Tagger.tag(track)
      end

    end
  end
end
