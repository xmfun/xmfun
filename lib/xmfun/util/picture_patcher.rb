# -*- encoding : utf-8 -*-

require 'open-uri'
require 'cgi'
require 'nokogiri'
require 'nori'

module Xmfun
  module Util
    class PicturePatcher
      def self.patch_file(file)
        title  = nil
        artist = nil

        Mp3Info.open(file) do |mp3|
          title  = mp3.tag.title
          artist = mp3.tag.artist
        end

        if title && artist
          url = "http://www.xiami.com/search?key=#{CGI::escape(title)}"
          search_result = Nokogiri::HTML(open(url, "Client-IP" => "220.181.111.168"))

          tr = search_result.css(".track_list tr").detect do |n|
            n.css("td[class='song_artist']").text.strip == artist &&
              n.css("td[class='song_name'] a[target='_blank']").text == title
          end

          link = tr.css("td[class='song_name'] a[target='_blank']").first['href']

          if link
            xml_link = Xmfun::Util::UrlParser.parse(link)
            track = Nokogiri::XML(open(xml_link, "Client-IP" => "220.181.111.168")).css("track").first

            song = Xmfun::Mp3::Track.new(Nori.new.parse(track.to_s)['track'], :file_name => file)

            Xmfun::Mp3::Mp3Tagger.tag(song)
          end
        else
          puts "\e[31mNo mp3 tag in #{file}\e[0m"
        end
      end

      def self.patch_folder(folder)
        Dir.glob(File.expand_path("#{folder}/**/*.mp3")).each do |file|
          patch_file file
        end
      end
    end
  end
end
