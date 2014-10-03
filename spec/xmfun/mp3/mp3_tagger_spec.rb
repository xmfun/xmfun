# -*- encoding : utf-8 -*-

require 'spec_helper'

module Xmfun
  module Mp3
    describe Mp3Tagger do
      before do
        @mp3_tagger  = Xmfun::Mp3::Mp3Tagger
      end

      describe ".tag" do
        before do
          @track = OpenStruct.new(
            'artist'    => 'polo',
            'album'     => 'smartisan',
            'title'     => 'I love this world',
            'file_name' => 'born_to_be_proud.mp3',
            'lyric'     => 'I love this world......',
            'album_pic' => 'This is a dummy picture from polo'
          )
          yielded_file = double('yielded_file')
          tag_mock     = double('tag')
          tag2_mock    = double('tag2')

          allow(tag_mock).to receive(:artist=).with('polo')
          allow(tag_mock).to receive(:title=).with('I love this world')
          allow(tag_mock).to receive(:album=).with('smartisan')

          allow(tag2_mock).to receive(:[]=).with('USLT', 'lyrics_text')
          allow(tag2_mock).to receive(:remove_pictures)
          allow(tag2_mock).to receive(:add_picture).with('dummy_picture')

          allow(yielded_file).to receive(:tag).and_return(tag_mock)
          allow(yielded_file).to receive(:tag2).and_return(tag2_mock)

          allow(Mp3Info).to receive(:open).with('born_to_be_proud.mp3').and_yield(yielded_file)
          allow(@mp3_tagger).to receive(:get_lyric).with('I love this world......').and_return('lyrics_text')
          allow(@mp3_tagger).to receive(:get_data).with('This is a dummy picture from polo').and_return('dummy_picture')
        end

        it '#should follow flow in tag' do
          @mp3_tagger.tag(@track)
        end
      end

      describe ".get_lyric" do
        before do
          raw_lyrics = "I&#039;m alright, I&#039;m just fine \xE6\x88\x91\xE5\xBE\x88\xE5\xA5\xBD\r\n\xE3\x80\x80\xE3\x80\x80"
          allow(@mp3_tagger).to receive(:get_data).with('lyrics_url').and_return(raw_lyrics)
        end

        it "#should return lyrics with right format" do
          expected_lyrics = "I'm alright, I'm just fine 我很好\r\n\u3000\u3000"
          expect(@mp3_tagger.get_lyric('lyrics_url')).to eq(expected_lyrics)
        end
      end

      describe ".get_data" do
        before do
          lyrics_url_mock        = double(read: 'lyrics_text')
          album_picture_url_mock = double(read: 'album_picture')

          allow(@mp3_tagger).to receive(:open).with('lyrics_url').and_return(lyrics_url_mock)
          allow(@mp3_tagger).to receive(:open).with('album_picture_url').and_return(album_picture_url_mock)
          allow(@mp3_tagger).to receive(:open).with('http://this.is.invalid_url').and_call_original
        end

        it "#should return lyrics_text when given lyrics_url" do
          expect(@mp3_tagger.get_data('lyrics_url')).to eq('lyrics_text')
        end

        it "#should return album_picture when given album_picture_url" do
          expect(@mp3_tagger.get_data('album_picture_url')).to eq('album_picture')
        end

        it "#should return empty string when given invalid_url" do
          expect(@mp3_tagger.get_data('http://this.is.invalid_url')).to eq('')
        end
      end
    end
  end
end
