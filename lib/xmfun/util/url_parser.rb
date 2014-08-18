# -*- encoding : utf-8 -*-

module Xmfun
  module Util
    class UrlParser
      def self.parse(url)
        if uri? url
          url_array = url.split("//").last.split(/(\/|\?)/)
          type, id = url_array[2], url_array[4]

          case type
           when "album"   then "http://www.xiami.com/song/playlist/id/#{id}/type/1"
           when "artist"  then "http://www.xiami.com/song/playlist/id/#{id}/type/2"
           when "collect" then "http://www.xiami.com/song/playlist/id/#{id}/type/3"
           when "song"    then "http://www.xiami.com/song/playlist/id/#{id}/object_name/default/object_id/0"
           else ""
          end
        else
         false
        end
      end

      def self.uri?(uri)
        uri =~ /\A#{URI::regexp(['http', 'https'])}\z/
      end
    end
  end
end
