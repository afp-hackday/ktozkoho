require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'cgi'

class FoafProxy
  @@foaf_query_base = 'http://foaf.sk'
  @@foaf_query_url = 'http://foaf.sk/?q='

  def self.related_companies(name,address = nil)
    doc = FoafProxy.foaf_query(name, address)
    own = parse_out_own(doc, 'ludia') #we do not want to process those records, which have URLs with 'ludia' included 
    related = parse_out_related_info(doc,'.col.f-r .item h3')
    own + related
  end

  def self.related_persons(name,address = nil)
    doc = FoafProxy.foaf_query(name, address)
    own = parse_out_own(doc, 'firmy')
    related = parse_out_related_info(doc, '.col.f-l .item h3')
    own + related
  end

  private

  def self.foaf_query(name, address)
    query = name
    query = query + " #{address}" unless address.nil?
    Nokogiri::HTML(open(@@foaf_query_url+CGI.escape(query)))
  end

  def self.parse_out_related_info(doc, selector)
    neighborhood = doc.css('#neighborhood a')
    if neighborhood.size > 0
      url_part = neighborhood[0]['href']
      Nokogiri::HTML(open(@@foaf_query_base + url_part).read.gsub('\\','')).css(selector).collect {|item| item.inner_text}
    else
      []
    end
  end

  def self.parse_out_own(doc, ommit)
    own_array = doc.css('.related a')
    return [] if own_array.empty?
    return [] if own_array.first['href'].match(/\/#{ommit}*/)
    results = own_array.collect {|item| item.inner_text }
  end
end

#companies = FoafProxy.related_companies("Microsoft")
#companies = FoafProxy.related_companies("Peter Čerešník", "Výtocká 16/41, Moravany nad Váhom")
#companies = FoafProxy.related_persons("Peter Čerešník", "Výtocká 16/41, Moravany nad Váhom")
#companies = FoafProxy.related_companies("blablabla")
#puts companies.inspect
