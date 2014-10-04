# -*- encoding : utf-8 -*-

require "open-uri"
require "mp3info"
require "cgi"

module Xmfun
  module Mp3
    class Mp3Tagger
      def self.tag(track)
        Mp3Info.open track.file_name do |m|
          m.tag.artist ||= track.artist
          m.tag.title  ||= track.title
          m.tag.album  ||= track.album_name

          m.tag2["USLT"] = get_lyric(track.lyric)
          m.tag2.remove_pictures
          m.tag2.add_picture(get_data(track.album_pic))
        end
      end

      private

      def self.get_lyric(url)
        CGI.unescapeHTML(get_data(url)).force_encoding("UTF-8")
      end

      def self.get_data(url)
        open(url).read rescue ''
      end
    end
  end
end
