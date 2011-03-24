# TODO: make a factory
class Scraper
  def build_conditions_query conditions_equal, conditions_less_or_equal
    #TODO: should be a class method?
    #TODO: complete and remove repetition 
    all_conditions = conditions_equal.map{|condition, value| "#{condition} = #{value.inspect.gsub("\"","\'")}"} + \
                     conditions_less_or_equal.map{|condition, value| "#{condition} <= #{value.inspect.gsub("\"","\'")}"}
    query = all_conditions.join(' AND ') 

    "(#{query})" 
  end

  def save house_params
    house_params.each{|param, value| puts "#{param.capitalize}: #{value}" }
    # House.create!(params)
  end

  # This method belong on the Scraper Class, or should it be on a Utility class???
  def self.load_config config_name
    url = File.join(File.dirname(__FILE__), '..', 'config', "#{config_name}.yml")
    open(url){ |f| YAML.load(f) }
  end

  def get_document_from_url base_url, params=nil
    url = URI.escape(@urls[base_url] + params)
    Nokogiri::HTML(open(url))
  end
end

