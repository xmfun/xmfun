# -*- encoding : utf-8 -*-

require 'cgi'
require 'active_support/core_ext/array/grouping'

module Xmfun
  module Util
    class Decoder
      def self.decode(input)
        begin
          row, text = strtok(input)

          tmp = text.in_groups(row).transpose.join
          CGI::unescape(tmp).gsub('^', '0')
        rescue ArgumentError
          false
        end
      end

      def self.strtok(s)
        m = /^(\d+)/.match(s)
        raise ArgumentError, "invalid input #{s}" unless m

        [$1.to_i, $'.chars.to_a]
      end
    end
  end
end
