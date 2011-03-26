require 'mechanize'
require_relative 'scraper'

class GallitoLuisScraper < Scraper
  #
  #TODO: this should be done in a separate task?
  #TODO: this shouldn't change very often
  def neighborhoods page
    #TODO: dummy!
    {"la comercial" => "53"}
  end

  def get_search_params page, selected_neighborhoods
    all_neighborhoods = neighborhoods page
    selected_neighborhoods.map{|n| "Check$#{all_neighborhoods[n]}"}  
  end

  def search_houses_form
    url = URI.escape(get_url_from_config 'gallito_search_properties')
    page = Mechanize.new.get(url)
  end

  def search_houses
    page = search_houses_form
    # TODO dummy, make search parameters list!
    neighborhoods = get_search_params page, ["la comercial"] 

    page.forms.first['__EVENTTARGET'] = neighborhoods.first 
    page.forms.first['__EVENTARGUMENT'] = ''

    # TODO: make this work
    # puts page.forms.first.checkbox(:name => 'Chkbar$53').node.inspect
    # neighborhoods.each{|neighborhood| page.forms.first.checkbox_with(:name => neighborhood).check }
    # p = page.forms.first.submit()

    # doc = Nokogiri::HTML(p.body)
    # # doc.search('script').find('src~=WebResource')
  end

  def scrap_house reference_id
    puts 'To be implemented'
  end
end
