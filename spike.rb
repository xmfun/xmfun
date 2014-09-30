require 'open-uri'
require 'nokogiri'
require 'nori'

url = "http://www.xiami.com/search?key=%E6%95%85%E4%B9%A1"
tracks = Nokogiri::HTML(open(url, "Client-IP" => "220.181.111.168"))

tr = tracks.css(".track_list tr").detect do |n|
  n.css("td[class='song_artist']").text.strip == "许巍" &&
    n.css("td[class='song_name'] a").first.text == "故乡"
end

link = tr.css("td[class='song_name'] a").first['href']
puts link
