# -*- encoding : utf-8 -*-
require 'xmfun/version'
require 'xmfun/url_parser'
require 'xmfun/decoder'
require 'xmfun/downloader'



module Xmfun
  def self.help
<<-HELP
Usage: ruby xmfun.rb
  -u url  -- url on xiami website
  -d path -- path to save your music
  -v      -- show version
  -h      -- show help message

Example:  Download song from "http://www.xiami.com/song/383221" and save to 'xuwei' folder
          xmfun -u http://www.xiami.com/song/383221 -d xuwei
HELP
  end
end
