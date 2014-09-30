# -*- encoding : utf-8 -*-

module Xmfun
  module Util
    module Helper
      def main_help
        <<-EOS
Usage: xmfun <command> [<args>]

  -v, --version       Print the version
  -h, --help          Print this help

Common commands:
  download            Download the mp3 files given an arg of url
  patch               Patch mp3 with album cover picture
  update              Update xmfun to the newest version
  version             Print the version
  help                Print this help

Example:
  xmfun download http://www.xiami.com/song/3378080

More info:
  xmfun <command> -h
        EOS
      end

      def download_help
        <<-EOS
Usage:
  xmfun download URL
  xmfun download URL -d DESINATION_FOLDER

Example:
  xmfun download http://www.xiami.com/song/3378080
  xmfun download http://www.xiami.com/song/3378080 -d pink
        EOS
      end

      def patch_help
        <<-EOS
Usage:
  xmfun patch [MP3_FILE | MP3_FOLDER ]

Example:
  xmfun patch music.mp3
  xmfun patch mp3_files/
        EOS
      end
    end
  end
end
