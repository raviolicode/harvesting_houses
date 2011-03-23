# TODO: make a factory
class Scraper
  def clean_field element 
    # TODO: bad smell! esto no va aca!
    element.inner_html.gsub(/&nbsp;/, '').downcase
  end

  def get_document_from_url base_url, params=nil
    #TODO: tampoco va aca
    url = URI.escape(@urls[base_url] + params)
    Nokogiri::HTML(open(url))
  end

  def build_conditions_query conditions_equal, conditions_less_or_equal
    all_conditions = conditions_equal.map{|condition, value| "#{condition} = #{value.inspect.gsub("\"","\'")}"} + \
                     conditions_less_or_equal.map{|condition, value| "#{condition} <= #{value.inspect.gsub("\"","\'")}"}
    query = all_conditions.join(' AND ') 

    "(#{query})" 
  end
end

