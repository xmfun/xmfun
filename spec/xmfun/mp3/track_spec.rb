# -*- encoding : utf-8 -*-

require 'spec_helper'

module Xmfun
  module Mp3
    describe Track do
      before do
        @track  = Xmfun::Mp3::Track
      end

      describe ".new" do
        before do
          @track_hash = {
            "location" => "10h%i5F1t2.%18tFn23.pfeF2m%1t11p3.%183Ax23_%iF312a3%3Fm522",
            "title"    => "I&#039;m很好",
            "artist"   => "P&#039;m很好",
          }
          @decoded_url = "http://f1.xiami.net/355/1133/13218_13218.mp3"

          allow(@track).to receive(:decode).with(@track_hash).and_return(@decoded_url)
        end

        it "#should return track of right format" do
          expected_track = OpenStruct.new(
            "location"  => @decoded_url,
            "title"     => "I'm很好",
            "artist"    => "P'm很好",
            "file_name" => "I'm很好_P'm很好.mp3"
          )

          expect(@track.new(@track_hash)).to eq(expected_track)
        end
      end
    end
  end
end
