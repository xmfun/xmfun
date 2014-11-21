# -*- encoding : utf-8 -*-

require 'spec_helper'

module Xmfun
  module Util
    describe Helper do
      class DummyClass
      end

      before(:all) do
        @dummy = DummyClass.new
        @dummy.extend Helper
      end

      describe ".main_help" do
        it "#should return main help information" do
          expected_help_info = <<-EOS
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
          expect(@dummy.main_help).to eq(expected_help_info)
        end
      end

      describe ".download_help" do
        it "#should return download help information" do
          expected_help_info = <<-EOS
Usage:
  xmfun download URL
  xmfun download URL -d DESINATION_FOLDER

Example:
  xmfun download http://www.xiami.com/song/3378080
  xmfun download http://www.xiami.com/song/3378080 -d pink
        EOS
          expect(@dummy.download_help).to eq(expected_help_info)
        end
      end

      describe ".proxy_help" do
        it "#should return proxy help information" do
          expected_proxy_info = <<-EOS
Usage:
  xmfun download URL proxy HTTP[S]_PROXY
  xmfun download URL -p HTTP[S]_PROXY
  xmfun download URL --proxy HTTP[S]_PROXY

Example:
  xmfun download http://www.xiami.com/song/3378080 proxy "http://111.1.3.38:8000"
  xmfun download http://www.xiami.com/song/3378080 -p "http://111.1.3.38:8000"
  xmfun download http://www.xiami.com/song/3378080 --proxy "http://111.1.3.38:8000"
        EOS
          expect(@dummy.proxy_help).to eq(expected_proxy_info)
        end
      end
    end
  end
end
