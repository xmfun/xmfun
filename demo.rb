require 'rubygems'
require 'open-uri'
require 'xml'

# Grab the raw XML from FriendFeed using open-uri
raw_xml = open("http://friendfeed.com/api/feed/user/simonstarr?format=xml").read

# Parse the XML with LibXml
# (this is where the magic happens)
source = XML::Parser.string(raw_xml) # source.class => LibXML::XML::Parser
content = source.parse # content.class => LibXML::XML::Document
puts content
# If you look at the XML from FriendFeed, each entry is contained in <entry> tags
entries = content.root.find('./entry') # entries.class => LibXML::XML::XPath::Object

entries.each do |entry| # entry.class => LibXML::XML::Node
  # This returns whatever's contained in the entry's <title> tags
  # E.g. <title>140 characters of wisdom</title>
  title = entry.find_first('title').content
  
  # Same for <published> and <link> tags
  published = entry.find_first('published').content
  link = entry.find_first('link').content
  
  # Do something useful with the data from the XML
  # E.g. new_post = Post.find_or_create_by_title_and_published_and_link(title, published, link)

  # This returns whatever's within the <id> tags inside the <service> tags
  # E.g. <service><id>twitter</id></service>
  short_name = entry.find_first('service/id').content
  
  # Same for <long_name> and <url> tags inside <service>
  long_name = entry.find_first('service/name').content
  url = entry.find_first('service/profileUrl').content
  
  # Do something with the data...
  # E.g. source = Source.find_or_create_by_short_name_and_long_name(short_name, long_name)
  # new_post.update_attribute(:source_id, source.id)
end
