# -*- encoding : utf-8 -*-

require 'singleton'

module Xmfun
  module Util
    class TaskManager
      include Xmfun::Util::Helper
      include Singleton

      attr_reader :_url, :_dst, :_proxy

      def initialize
        @_url = ''
        @_dst = '.'
      end

      def download(option)
        if option == '-h'
          puts download_help
        else
          unless @_url = Xmfun::Util::UrlParser.parse(option)
            puts "\e[31mPlease provide valid xmfun URL\e[0m"
            exit
          end
        end
      end

      def proxy(option)
        if option == '-h'
          puts proxy_help
        else
          unless @_proxy = Xmfun::Util::UrlParser.uri?(option)
            puts "\e[31mPlease provide valid proxy URL\e[0m"
            exit
          end
        end
      end

      def update
        system("gem update xmfun")
      end

      def help
        puts main_help
        exit
      end

      def version
        puts Xmfun::VERSION
        exit
      end

      def destination(d)
        @_dst = d
      end

      def url(u)
        @_url = u
      end

      alias_method :"--help", :help
      alias_method :"-h", :help
      alias_method :"-d", :destination
      alias_method :"-v", :version
      alias_method :"--version", :version
      alias_method :"-u", :url
      alias_method :"-p", :proxy
      alias_method :"--proxy", :proxy

      def tasks
        filtered_method = self.class.instance_methods(false) - [:tasks, :go!, :"_url", :"_dst", :"_proxy"]
        filtered_method.inject({}) { |h, n| h.update(n.to_s => method(n)) }
      end

      def go!
        Xmfun::Download::DownloaderManager.new(_url, _dst, _proxy).start unless _url.empty?
      end
    end
  end
end
