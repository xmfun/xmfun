require 'mini_test_helper'

module Xmfun
	module Util
		class TestHelper < Minitest::Test
			class DummyClass
			end

			def setup
				@dummy = DummyClass.new
				@dummy.extend Xmfun::Util::Helper
			end

			def test_main_help__return_main_help_information
        expected_help_info = <<-EOS
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

        assert_equal @dummy.main_help, expected_help_info
			end

			def test_download_help__return_download_help_information
				expected_help_info = <<-EOS
Usage:
  xmfun download URL
  xmfun download URL -d DESINATION_FOLDER

Example:
  xmfun download http://www.xiami.com/song/3378080
  xmfun download http://www.xiami.com/song/3378080 -d pink
        EOS

        assert_equal @dummy.download_help, expected_help_info
			end
		end
	end
end