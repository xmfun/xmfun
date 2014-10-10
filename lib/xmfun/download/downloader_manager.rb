# -*- encoding : utf-8 -*-

require 'open-uri'
require 'nokogiri'
require 'nori'
require 'parallel'
require 'ruby-progressbar'

module Xmfun
  module Download
    class DownloaderManager
      attr_accessor :track_list, :downloader

      def initialize(url, dst = ".")
        make_dst(dst)

        @track_list = fetch_track_list(url)

        if @track_list.size > 1
          @downloader = CollectDownloader.new
        else
          @downloader = SongDownloader.new
        end
      end

      def start
        @downloader.download(track_list)
      end

      private

      def fetch_track_list(url)
        Nokogiri::XML(open(url, "Client-IP" => "220.181.111.168")).css("track")
      end

      def make_dst(dst)
        if Dir.exist?(dst)
          Dir.chdir(dst)
        else
          Dir.mkdir(dst)
          Dir.chdir(dst)
        end
      end
    end
  end
end
