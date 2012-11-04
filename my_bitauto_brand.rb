#encoding: UTF-8
require 'rubygems'
require 'mongoid'
require 'nokogiri'
require 'open-uri'
require 'logger'
require 'pp'
require 'chinese_pinyin'

require_relative 'brand_url_lists'
require_relative 'file_io'


Dir.glob("#{File.dirname(__FILE__)}/app/models/*.rb") do |lib|
  require lib
end


#ENV['MONGOID_ENV'] = 'local_dev' 	#127.0.0.1:27017
ENV['MONGOID_ENV'] = 'dev'  		#211.101.12.237:27017

Mongoid.load!("config/mongoid.yml")


def create_file_to_write
	file_path = File.join('.', "brands-import.txt")
	@file_to_write = IoFactory.init(file_path)
end

create_file_to_write

total = @url_items.count

@url_items.each_with_index do |url, i|
puts url.split('/')[3]
#break

	detail_url = "#{url}"
	puts "#{i}/#{total} : #{detail_url}"
	@doc = Nokogiri::HTML(open(detail_url).read.strip)

	#logo_url = @doc.at_xpath('//div[@class = "line_box"]//img/@src')
	logo_url = @doc.at_css('div.logo_story > dl > dt > img').attr("src")
	brand_summary = @doc.at_css('div#aa').text.strip_tag.strip
	logo_summary = @doc.at_css('div#bb').text.strip_tag.strip
	brand_name = @doc.at_css('h1 > a').text.strip
	name_pinyin = Pinyin.t(brand_name, '').downcase.to_s

	@file_to_write.puts "#{Time.now.to_formatted_s(:number)}\t #{i}\t#{brand_name}\t#{name_pinyin}\t#{brand_summary}\t#{logo_summary}\t#{logo_url}"

	@brand = Brand.find_or_create_by(name: brand_name)

	@brand.name = brand_name
	@brand.name_pinyin = name_pinyin
  @brand.name_en = url.split('/')[3]
	@brand.brand_summary = brand_summary
	@brand.logo_summary = logo_summary
  @brand.display_index = 1
  @brand.hot_index = 1

  @brand.temp_logo_url = logo_url

	@brand.save

end
              
