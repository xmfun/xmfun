# -*- encoding : utf-8 -*-

require 'xmfun/version'
require 'xmfun/mp3/track'
require 'xmfun/mp3/mp3_tagger'
require 'xmfun/util/url_parser'
require 'xmfun/util/decoder'
require 'xmfun/downloader'



module Xmfun
  def self.main_help
<<-EOS
Usage: xmfun <command> [<args>]

  -v, --version       Print the version
  -h, --help          Print this help

Common commands:
  download            Download the mp3 files given an arg of url
  update              Update xmfun to the newest version
  version             Print the version
  help                Print this help

Example:
  xmfun download http://www.xiami.com/song/3378080

More info:
  xmfun <command> -h
EOS
  end

  def self.download_help
<<-EOS
Usage:
  xmfun download URL
  xmfun download URL -d DESINATION_FOLDER

Example:
  xmfun download http://www.xiami.com/song/3378080
  xmfun download http://www.xiami.com/song/3378080 -d pink
EOS
  end
end
