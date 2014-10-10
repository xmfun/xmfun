# -*- encoding : utf-8 -*-

module Xmfun
  module Download
    class CollectDownloader < Downloader
      def initialize
        set_progress_options
      end

      def download(track_list)
        @progress = make_progress_bar(track_list.size)

        Parallel.map(track_list, in_threads: processor_count, finish: progress_proc) do |track|
          track = make_track(track)

          URI.parse(track.location).open(&write_to_file_proc(track))

          Xmfun::Mp3::Mp3Tagger.tag(track)
        end
      end

      private

      def set_progress_options
        @progress = nil
        @progress_proc = progress_proc
      end

      def progress_proc
        Proc.new { @progress.increment }
      end

      def processor_count
        Parallel.processor_count
      end
    end
  end
end
