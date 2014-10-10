# -*- encoding : utf-8 -*-

module Xmfun
  module Download
    class SongDownloader < Downloader
      def initialize
        set_progress_options
      end

      def download(track_list)
        song = track_list.first
        track = make_track(song)

        uri = URI.parse(track.location)

        uri.open(content_length_proc: @content_length_proc,
                 progress_proc:       @progress_proc,
                 &write_to_file_proc(track))

        Xmfun::Mp3::Mp3Tagger.tag(track)
      end

      private

      def set_progress_options
        @progress = nil
        @content_length_proc = content_length_proc
        @progress_proc = progress_proc
      end

      def content_length_proc
        lambda do |content_length|
          if content_length && 0 < content_length
            @progress = make_progress_bar content_length
          end
        end
      end

      def progress_proc
        ->(size) { @progress.progress = size if @progress }
      end
    end
  end
end
