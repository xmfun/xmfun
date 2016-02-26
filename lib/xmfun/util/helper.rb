# -*- encoding : utf-8 -*-

module Xmfun
  module Util
    module Helper
      def main_help
        <<-EOS
Usage: xmfun <command> [<args>]

  -v, --version       Print the version
  -h, --help          Print this help
  -p, --proxy         Set Proxy Server

Common commands:
  download            Download the mp3 files given an arg of url
  proxy               Set Proxy Server
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

      def proxy_help
        <<-EOS
Usage:
  xmfun download URL proxy HTTP[S]_PROXY
  xmfun download URL -p HTTP[S]_PROXY
  xmfun download URL --proxy HTTP[S]_PROXY

Example:
  xmfun download http://www.xiami.com/song/3378080 proxy "http://111.1.3.38:8000"
  xmfun download http://www.xiami.com/song/3378080 -p "http://111.1.3.38:8000"
  xmfun download http://www.xiami.com/song/3378080 --proxy "http://111.1.3.38:8000"
        EOS
      end
    end
  end
end
