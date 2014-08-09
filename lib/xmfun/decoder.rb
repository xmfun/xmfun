require 'cgi'

module Xmfun
  class Decoder
    def self.decode(input)
      text = input[1..-1]
      row = input[0].to_i
      col = text.size / row - 1
      reminder = text.size % row
      result = []
      start = 0

      row.times do |r|
        if reminder == 0
          result << text[start..(start+col)]
          start = start + col + 1
        else
          result << text[start..(start+col+1)]
          start = start + col + 2
        end
        if reminder != 0
          reminder = reminder - 1
        end
      end

      tmp = (0..(result[0].size-1)).to_a.map do |n|
        result.map{|i| i[n]}.join
      end.join

      CGI::unescape(tmp).gsub('^', '0')
    end

  end
end
