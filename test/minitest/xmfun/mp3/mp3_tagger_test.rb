require 'mini_test_helper'

module Xmfun
	module Mp3
		class TestMp3Tagger < MiniTest::Test
			def setup
				@mp3_tagger = Xmfun::Mp3::Mp3Tagger
			end

			def test_tag__should_follow_flow_in_tag
				track = OpenStruct.new(
				  'artist'      => 'polo',
				  'album_name'  => 'smartisan',
				  'title'       => 'I love this world',
				  'file_name'   => 'born_to_be_proud.mp3',
				  'lyric'       => 'I love this world......',
				  'album_pic'   => 'This is a dummy picture from polo'
				)

				yielded_file = mock('yielded_file')
				tag_mock = mock('tag')
				tag2_mock = mock('tag2')

				yielded_file.expects(:tag).returns(tag_mock).times(3)
				yielded_file.expects(:tag2).returns(tag2_mock).times(3)

				tag_mock.expects(:artist).returns(nil)
				tag_mock.expects(:title).returns(nil)
				tag_mock.expects(:album).returns(nil)

				tag_mock.expects(:artist=).with('polo').once
				tag_mock.expects(:title=).with('I love this world').once
				tag_mock.expects(:album=).with('smartisan').once

				tag2_mock.expects(:[]=).with('USLT', 'lyrics_text').once
				tag2_mock.expects(:remove_pictures).once
				tag2_mock.expects(:add_picture).with('dummy_picture').once

				Mp3Info.expects(:open).with('born_to_be_proud.mp3').yields(yielded_file).once
				@mp3_tagger.expects(:get_lyric).with('I love this world......').returns('lyrics_text')
				@mp3_tagger.expects(:get_data).with('This is a dummy picture from polo').returns('dummy_picture')

				@mp3_tagger.tag(track)
			end

			def test_get_lyric__return_lyrics_with_right_format
				raw_lyrics = "I&#039;m alright, I&#039;m just fine \xE6\x88\x91\xE5\xBE\x88\xE5\xA5\xBD\r\n\xE3\x80\x80\xE3\x80\x80"
				@mp3_tagger.expects(:get_data).with('lyrics_url').returns(raw_lyrics).once

				expected_lyrics = "I'm alright, I'm just fine 我很好\r\n\u3000\u3000"
				assert_equal @mp3_tagger.get_lyric('lyrics_url'), expected_lyrics
			end

			def test_get_data__return_lyrics_text_when_given_lyrics_url
				lyrics_url_mock = mock(read: 'lyrics_text')

				@mp3_tagger.expects(:open).with('lyrics_url').returns(lyrics_url_mock)

				assert_equal @mp3_tagger.get_data('lyrics_url'), 'lyrics_text'
			end

			def test_get_data__return_album_picture_when_given_album_picture_url
				album_picture_url_mock = mock(read: 'album_picture')

				@mp3_tagger.expects(:open).with('album_picture_url').returns(album_picture_url_mock)

				assert_equal @mp3_tagger.get_data('album_picture_url'), 'album_picture'
			end

			def test_get_data__return_empty_string_when_given_invalid_url
				assert_equal @mp3_tagger.get_data('http://this.is.invalid_url'), ''
			end
		end
	end
end