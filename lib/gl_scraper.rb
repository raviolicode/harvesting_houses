require 'mechanize'
require_relative 'scraper'

class GallitoLuisScraper < Scraper
  #TODO: this should be done in a separate task or it should be in a config file?
  #TODO: this shouldn't change very often
  def all_neighborhoods page
    #TODO: dummy!
    {"la comercial" => "53"}
  end

  def get_search_params form, selected_neighborhoods
    neighborhoods = all_neighborhoods form 
    selected_neighborhoods.map{|n| "Chkbar$#{neighborhoods[n]}"}  
  end

  def search_houses_form
    url = URI.escape(get_url_from_config 'gallito_search_properties')
    page = Mechanize.new.get(url)
    form = page.forms.first
  end

  def search_houses
    form = search_houses_form
    # TODO dummy, make search parameters list!
    neighborhoods = get_search_params form, ["la comercial"] 

    # submit search form
    form['__EVENTTARGET'] = neighborhoods.first 
    form['__EVENTARGUMENT'] = ''
    neighborhoods.each{|input_value| form.checkbox(:name => input_value).check }
    page = form.submit()

    get_houses_list_from_response page
  end

  def get_houses_list_from_response page
    doc = Nokogiri::HTML(page.body)
    scripts = doc.search('script')
    # google_maps_script = scripts.find{|s| s.children.length > 0 && s.children.first.content[/GMapsProperties/]}.content

    # without_cdata_regexp = /\r\n\/\/<!\[CDATA\[\r\n(.*)\/\/\]\]/
    # script_without_cdata = google_maps_script[without_cdata_regexp, 1] 
    # info_window_sentence = google_maps_script[/7906_.openInfoWindowHtml\(\'(.*)\'\);/]
  end

  def scrap_house reference_id
    puts 'To be implemented'
  end
end
