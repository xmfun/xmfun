# -*- encoding : utf-8 -*-

require 'cgi'
require 'active_support/core_ext/array/grouping'

module Xmfun
  module Util
    class Decoder
      def self.decode(input)
        text = input[1..-1].chars.to_a
        row = input[0].to_i

        tmp = text.in_groups(row).transpose.join
        CGI::unescape(tmp).gsub('^', '0')
      end
    end
  end
end
