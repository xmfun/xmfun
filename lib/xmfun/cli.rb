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

      download_proc = lambda do |option|
        if option == '-h'
          puts download_help
        else
          if (url = Xmfun::Util::UrlParser.parse(option))
            Xmfun::Util::Downloader.download(url) unless url.empty?
          else
            puts "\e[31mPlease provide valid URL\e[0m"
            exit
          end
        end
      end

      patch_proc = lambda do |option|
        if option == '-h'
          puts patch_help
        else
          if (File.file? option)
            Xmfun::Util::PicturePatcher.patch_file(option)
          elsif (File.directory? option)
            Xmfun::Util::PicturePatcher.patch_folder(option)
          else
            puts "\e[31mPlease provide valid file or directory\e[0m"
            exit
          end
        end
      end

      begin
        Clap.run argv,
          "download"   => download_proc,
          "patch"      => patch_proc,
          "update"     => lambda { system("gem update xmfun") },
          "help"       => lambda { puts main_help; exit },
          "--help"     => lambda { puts main_help; exit },
          "version"    => lambda { puts Xmfun::VERSION; exit },
          "--version"  => lambda { puts Xmfun::VERSION; exit },

          "-v" => lambda { puts Xmfun::VERSION; exit},
          "-h" => lambda { puts main_help; exit}
      rescue ArgumentError
        puts "\e[31mInvalid Usage\e[0m"
        puts main_help
      end
    end
  end
end
