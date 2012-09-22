#encoding: UTF-8
require 'rubygems'
require 'mongoid'
require 'nokogiri'
require 'open-uri'
require 'logger'
require 'pp'
require 'chinese_pinyin'

Dir.glob("#{File.dirname(__FILE__)}/app/models/*.rb") do |lib|
  require lib
end


#ENV['MONGOID_ENV'] = 'localcar'
ENV['MONGOID_ENV'] = 'che'

Mongoid.load!("config/mongoid.yml")
class String
    def br_to_new_line
        self.gsub('<br>', "\n")
    end
    def n_to_nil
        self.gsub('\n', "")
    end
    def strip_tag
        self.gsub(%r[<[^>]*>], '').gsub(/\t|\n|\r/, ' ')
    end
end #String
class IoFactory
        attr_reader :file
        def self.init file
                @file = file
                if @file.nil?
                        puts 'Can Not Init File To Write'
                        exit
                end #if
                File.open @file, 'a'
        end
end #IoFactory

def create_file_to_write
        file_path = File.join('.', "1baoyang-#{Time.now.to_formatted_s(:number) }.txt")
        @file_to_write = IoFactory.init(file_path)
end

create_file_to_write


create_file_to_write

@url_items = %w(
http://car.bitauto.com/saab/
http://car.bitauto.com/seat/
)

@url_items.each_with_index do |url, i|

        detail_url = "#{url}"
        puts "#{i} : #{detail_url}"
        @doc = Nokogiri::HTML(open(detail_url).read.strip)

        #logo_url = @doc.at_xpath('//div[@class = "line_box"]//img/@src')
        logo_url = @doc.at_css('div.logo_story > dl > dt > img').attr("src")
        brand_summary = @doc.at_css('div#aa').text.strip_tag.strip
        logo_summary = @doc.at_css('div#bb').text.strip_tag.strip
        brand_name = @doc.at_css('h6 > a').text.strip
        name_pinyin = Pinyin.t(brand_name, '').downcase.to_s


        #@file_to_write.
        puts "#{i}\t#{brand_name}\t#{name_pinyin}\t#{brand_summary}\t#{logo_summary}\t#{logo_url}"

        @brand = Brand.find_or_create_by(name: brand_name)

        @brand.name = brand_name
        @brand.name_pinyin = name_pinyin
        @brand.brand_summary = brand_summary
        @brand.logo_summary = logo_summary
        @brand.temp_logo_url = logo_url

@brand.save


end
              