# -*- encoding : utf-8 -*-

require 'ostruct'
require 'cgi'

module Xmfun
  module Mp3
    class Track
      def self.new(track_hash)
        track_hash["location"] = Xmfun::Util::Decoder.decode(track_hash["location"])
        track_hash["title"]    = CGI.unescapeHTML(track_hash["title"])
        track_hash["artist"]   = CGI.unescapeHTML(track_hash["artist"])

        track_hash["file_name"] = "#{track_hash["title"]}_#{track_hash["artist"]}.mp3"
        OpenStruct.new track_hash
      end
    end
  end
end

