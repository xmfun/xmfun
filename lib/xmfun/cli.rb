# -*- encoding : utf-8 -*-

require 'clap'

module Xmfun
  class CLI
    extend Xmfun::Util::Helper

    def self.start(argv)
      if argv.empty?
        puts main_help
        exit
      end

      url = ''
      dst = '.'

      download_proc = lambda do |option|
        if option == '-h'
          puts download_help
        else
          unless(url = Xmfun::Util::UrlParser.parse(option))
            puts "\e[31mPlease provide valid URL\e[0m"
            exit
          end
        end
      end

      begin
        Clap.run argv,
          "download"   => download_proc,
          "update"     => lambda { system("gem update xmfun") },
          "help"       => lambda { puts main_help; exit},
          "--help"     => lambda { puts mian_help; exit},
          "version"    => lambda { puts Xmfun::VERSION; exit},
          "--version"  => lambda { puts Xmfun::VERSION; exit},

          "-u" => lambda { |xmurl|  url = Xmfun::Util::UrlParser.parse(xm_url) },
          "-v" => lambda { puts Xmfun::VERSION; exit},
          "-h" => lambda { puts main_help; exit},
          "-d" => lambda { |d| dst = d }
      rescue ArgumentError
        puts "\e[31mInvalid Usage\e[0m"
        puts main_help
      end

      Xmfun::Util::Downloader.download(url, dst) unless url.empty?
    end
  end
end
