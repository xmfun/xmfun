require 'minitest/autorun'
require 'mini_test_helper'

module Xmfun
	module Util
		class TestUrlParser < Minitest::Test
			def setup
				@urlParser = Xmfun::Util::UrlParser
			end

			def test_parse__return_url_for_corresponding_type
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

				assert_equal @urlParser.parse(album_url), expected_album_url
				assert_equal @urlParser.parse(artist_url), expected_artist_url
				assert_equal @urlParser.parse(collect_url), expected_collect_url
				assert_equal @urlParser.parse(song_url), expected_song_url
				assert_empty @urlParser.parse(unknown_type_url)
				refute @urlParser.parse(invalid_url)
			end

			def test_uri__return_true_with_valid_uri_otherwise_false
				valid_uri   = "http://www.xiami.com/song/3446250?from=search_popup_song"
        invalid_uri = "this is an invalid url"

        assert_equal @urlParser.uri?(valid_uri), 0
        assert_nil @urlParser.uri?(invalid_uri)
			end
		end
	end
end