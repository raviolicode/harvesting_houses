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
    selected_neighborhoods.map{|n| "Chkbar$#{all_neighborhoods[n]}"}  
  end

  def search_houses_form
    url = URI.escape(get_url_from_config 'gallito_search_properties')
    page = Mechanize.new.get(url)
  end

  def search_houses
    page = search_houses_form
    form = page.forms.first
    # TODO dummy, make search parameters list!
    n = get_search_params page, ["la comercial"] 

    form['__EVENTTARGET'] = n.first 
    form['__EVENTARGUMENT'] = ''

    # n = neighborhoods page

    # TODO: make this work
    puts n.inspect
    n.each{|input_value| page.forms.first.checkbox(:name => input_value).check }
    puts page.forms.first.checkbox(:name => 'Chkbar$53').node.inspect
    p = page.forms.first.submit()

    doc = Nokogiri::HTML(p.body)
    puts doc.search('script').find('src~=WebResource').inspect
    doc.search('script')#.find('src~=WebResource')
  end

  def scrap_house reference_id
    puts 'To be implemented'
  end
end
