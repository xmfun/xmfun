# -*- encoding : utf-8 -*-

require 'cgi'

module Xmfun
  module Util
    class Decoder
      def self.decode(input)
        row, text = strtok(input)

        tmp = text.in_groups(row).transpose.join
        CGI::unescape(tmp).gsub("^", "0")
      rescue ArgumentError
        false
      end

      def self.strtok(s)
        m = /^(\d+)/.match(s)
        raise ArgumentError, "invalid input #{s}" unless m

        [$1.to_i, $'.chars.to_a]
      end
    end
  end
end
