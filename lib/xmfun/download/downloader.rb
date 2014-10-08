# -*- encoding : utf-8 -*-

module Xmfun
  module Download
    class Downloader
      def download(*)
        raise 'Abstract method called'
      end

      def make_progress_bar(size)
        ProgressBar.create( title: "Progress",
                            total: size,
                            format: '%a %bᗧ%i %p%% %t',
                            progress_mark: ' ',
                            remainder_mark: '･' )
      end

      def make_track(source)
        Xmfun::Mp3::Track.new(Nori.new.parse(source.to_s)['track'])
      end

      def write_to_file_proc(track)
        ->(f) { File.open(track.file_name, 'w') { |mp3| mp3.write(f.read) } }
      end
    end
  end
end
