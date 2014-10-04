# -*- encoding : utf-8 -*-

require 'spec_helper'

module Xmfun
  module Util
    describe UrlParser do
      before do
        @url_parser = Xmfun::Util::UrlParser
      end

      describe ".parse" do
        it "#should return a url of corresponding type(album, artist, collect, song)" do
          album_url        = "http://www.xiami.com/album/11669"
          artist_url       = "http://www.xiami.com/artist/778"
          collect_url      = "http://www.xiami.com/collect/34833271"
          song_url         = "http://www.xiami.com/song/2181181"
          unknown_type_url = "http://www.xiami.com/polo/218"
          invalid_url      = "this is an invalid url"

          expected_album_url   = "http://www.xiami.com/song/playlist/id/11669/type/1"
          expected_artist_url  = "http://www.xiami.com/song/playlist/id/778/type/2"
          expected_collect_url = "http://www.xiami.com/song/playlist/id/34833271/type/3"
          expected_song_url    = "http://www.xiami.com/song/playlist/id/2181181/object_name/default/object_id/0"

          expect(@url_parser.parse(album_url)).to eq(expected_album_url)
          expect(@url_parser.parse(artist_url)).to eq(expected_artist_url)
          expect(@url_parser.parse(collect_url)).to eq(expected_collect_url)
          expect(@url_parser.parse(song_url)).to eq(expected_song_url)
          expect(@url_parser.parse(unknown_type_url)).to eq("")
          expect(@url_parser.parse(invalid_url)).to be false
        end
      end

      describe ".uri?" do
        it "#should return true given a valid uri otherwise return false" do
          valid_uri   = "http://www.xiami.com/song/3446250?from=search_popup_song"
          invalid_uri = "this is an invalid url"

          expect(@url_parser.uri?(valid_uri)).to be 0
          expect(@url_parser.uri?(invalid_uri)).to be nil
        end
      end
    end
  end
end
