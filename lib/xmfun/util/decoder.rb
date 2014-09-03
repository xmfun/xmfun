# -*- encoding : utf-8 -*-

require 'cgi'
require 'active_support/core_ext/array/grouping'

module Xmfun
  module Util
    class Decoder
      def self.decode(input)
        input.match(/^(\d+)/)
        row, text = $1.to_i, $'.chars.to_a

        tmp = text.in_groups(row).transpose.join
        CGI::unescape(tmp).gsub('^', '0')
      end
    end
  end
end
