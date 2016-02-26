require 'mini_test_helper'

module Xmfun
  module Mp3
    class TestTrack < MiniTest::Test
      def setup
        @tracker = Xmfun::Mp3::Track
        @decoder = Xmfun::Util::Decoder
      end

      def test_new__return_track_of_right_format
        track_hash = {
          "location" => "10h%i5F1t2.%18tFn23.pfeF2m%1t11p3.%183Ax23_%iF312a3%3Fm522",
          "title"    => "I&#039;m很好",
          "artist"   => "P&#039;m很好",
        }
        decoded_url = "http://f1.xiami.net/355/1133/13218_13218.mp3"

        @decoder.expects(:decode).with(track_hash['location']).returns(decoded_url)

        expected_track = OpenStruct.new(
          "location"  => decoded_url,
          "title"     => "I'm很好",
          "artist"    => "P'm很好",
          "file_name" => "I'm很好_P'm很好.mp3"
        )

        assert_equal @tracker.new(track_hash), expected_track
      end
    end
  end
end
