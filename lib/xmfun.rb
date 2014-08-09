require 'xmfun/version'
require 'xmfun/decoder'
require 'xmfun/downloader'



module Xmfun
  def self.help
<<-HELP
Usage: ruby xmfun.rb
  -c cid  -- download a music collect
  -s sid  -- download a single song
  -d path -- path to save your music
  -v      -- show version
  -h      -- show help message

Example:  Download Collect with ID 10181268 and save to current path
          xmfun -c 10181268 -d .
HELP
  end
end
