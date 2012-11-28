require 'net/http'
require 'rubygems'
require 'xmlsimple'

url = 'http://api.search.yahoo.com/WebSearchService/V1/webSearch?appid=YahooDemo&query=madonna&results=2'
xml_data = Net::HTTP.get_response(URI.parse(url)).body

data = XmlSimple.xml_in(xml_data)

data['Result'].each do |item|
   item.sort.each do |k, v|
      if ["Title", "Url"].include? k
         print "#{v[0]}" if k=="Title"
         print " => #{v[0]}\n" if k=="Url"
      end
   end
end
