#encoding: UTF-8
require 'rubygems'
require 'mongoid'


Dir.glob("#{File.dirname(__FILE__)}/app/models/*.rb") do |lib|
    require lib
end


ENV['MONGOID_ENV'] = 'dev'


Mongoid.load!("config/mongoid.yml")


@url_items = %w(
http://car.bitauto.com/saab/
http://car.bitauto.com/seat/
)
@name = %w{
萨博
西雅特
新大地
中顺
黄海
江淮
柯尼赛格
铃木
理念
蓝旗亚
马自达
MG
美亚
纳智捷
欧宝
欧朗
奇瑞
吉利全球鹰
启辰
瑞麒
三菱
斯巴鲁
Smart
双龙
双环
世爵
五菱
雪佛兰
雪铁龙
星客特
新凯
一汽
英菲尼迪
野马
宇通
友谊客车
中华
众泰
中欧
奥迪
阿斯顿·马丁
阿尔法·罗米欧
ACSchnitzer
本田
别克
宝马
比亚迪
奔驰
标致
保时捷
奔腾
宝骏
北汽制造
北京汽车
布加迪
宾利
巴博斯
北汽威旺
宝龙
长城
长安轿车
长安商用
长丰
昌河
大众
吉利帝豪
东南
东风风行
东风
东风风神
道奇
DS
大通
大迪
丰田
福特
法拉利
菲亚特
福田
福迪
富奇
广汽
广汽吉奥
GMC
光冈
广汽日野
海马
华泰
悍马
哈飞
海马商用车
华普
红旗
海格
汇众
恒天汽车
航天圆通
吉普
金杯
捷豹
江铃
江南
金龙联合
俊风
九龙
金旅客车
凯迪拉克
克莱斯勒
开瑞
路虎
雷克萨斯
莲花
兰博基尼
力帆
雷诺
陆风
劳斯莱斯
林肯
路特斯
MINI
玛莎拉蒂
迈巴赫
讴歌
起亚
庆铃
日产
荣威
斯柯达
天马
沃尔沃
威麟
现代
吉利英伦
永源
依维柯
中兴
中客华北
}

@country = %w{
瑞典
西班牙
中国
中国
中国
中国
瑞典
日本
中国
意大利
日本
英国
中国 
中国
德国
中国
中国
中国
中国
中国
日本
日本
德国
韩国
中国
荷兰
中国
美国
法国
中国
中国
中国
日本
美国
中国
中国
中国
中国
中国
德国
英国
意大利
德国
日本
美国
德国
中国
德国
法国
德国
中国
中国
中国
中国
法国
英国
德国
中国
中国
中国
中国
中国
中国
中国
德国
中国
中国
中国
中国
中国
美国
法国
中国
中国
日本
美国
意大利
意大利
中国
中国
中国
中国
中国
美国
日本
中国
中国
中国
美国
中国
中国
中国
中国
中国
中国
中国
中国
美国
中国
英国
中国
中国
中国
中国
中国
中国
美国
美国
中国
英国
日本
英国
意大利
中国
法国
中国
英国
美国
英国
德国
意大利
德国
日本
韩国
中国
日本
中国
捷克
中国
瑞典
中国
韩国
中国
中国
中国
中国
中国
}
@class_tag = %w{
欧系品牌
欧系品牌
自主品牌
自主品牌
自主品牌
自主品牌
欧系品牌
日系品牌
自主品牌
欧系品牌
日系品牌
欧系品牌
自主品牌
自主品牌
欧系品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
日系品牌
日系品牌
欧系品牌
韩系品牌
自主品牌
欧系品牌
自主品牌
美系品牌
欧系品牌
自主品牌
自主品牌
自主品牌
日系品牌
美系品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
欧系品牌
欧系品牌
欧系品牌
欧系品牌
日系品牌
美系品牌
欧系品牌
自主品牌
欧系品牌
欧系品牌
欧系品牌
自主品牌
自主品牌
自主品牌
自主品牌
欧系品牌
欧系品牌
欧系品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
欧系品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
美系品牌
欧系品牌
自主品牌
自主品牌
日系品牌
美系品牌
欧系品牌
欧系品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
美系品牌
日系品牌
自主品牌
自主品牌
自主品牌
美系品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
美系品牌
自主品牌
欧系品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
美系品牌
美系品牌
自主品牌
欧系品牌
日系品牌
欧系品牌
欧系品牌
自主品牌
欧系品牌
自主品牌
欧系品牌
美系品牌
欧系品牌
欧系品牌
欧系品牌
欧系品牌
日系品牌
韩系品牌
自主品牌
日系品牌
自主品牌
欧系品牌
自主品牌
欧系品牌
自主品牌
韩系品牌
自主品牌
自主品牌
自主品牌
自主品牌
自主品牌
}

puts @name.length
puts @country.length
puts @class_tag.length
puts Brand.all.count()

@name.each_with_index do |n, i|

  puts "#{i}-#{n}-#{@country[i]}-#{@class_tag[i]}"
  if n == "ACSchnitzer"
    n= "AC Schnitzer"
  end
    @brand = Brand.find_by(name: n)
      if @brand.nil?
          puts "no such"
            else
                puts "yse , set."
                    @brand.country = @country[i]
                        @brand.class_tag = @class_tag[i]
                            @brand.save
                              end
end
