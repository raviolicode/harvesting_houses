require 'rubygems'
require_relative 'bc_scraper'

bc = BuscandoCasaScraper.new
refs = bc.houses_reference_ids
refs.each do |ref|
  puts '*-----------------------------------*'
  puts ref
  puts '*-----------------------------------*'
  house_data = bc.scrap_house ref
  puts (bc.save house_data).inspect
end

