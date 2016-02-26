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

      def initialize(url, dst = ".", proxy)
        make_dst(dst)

        @track_list = fetch_track_list(url, proxy)

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

      def fetch_track_list(url, http_proxy)
        Nokogiri::XML(open(url, proxy: http_proxy)).css("track")
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
