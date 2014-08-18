# -*- encoding : utf-8 -*-

require 'open-uri'
require 'mp3info'

module Xmfun
  module Mp3
    class Mp3Tagger
      def self.tag(track)
        Mp3Info.open track.file_name do |m|
          m.tag.artist = track.artist
          m.tag.title  = track.title
          m.tag.album  = track.album

          m.tag2.remove_pictures
          m.tag2.add_picture(open(track.album_pic).read)
        end
      end
    end
  end
end
