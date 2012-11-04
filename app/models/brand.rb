class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
   #名称，logo，国家，品牌说明，logo说明
  field :name, type: String
  field :name_pinyin, type: String
  field :name_en, type: String
  field :country, type: String
  field :class_tag, type: String
 
  field :brand_summary, type: String
  field :logo_summary, type: String
  field :display_index, type: Integer
  field :hot_index, type: Integer

  field :temp_logo_url, type: String

  #mount_uploader :logo_image, PhotoUploader

  index({name: 1})
  index({name_pinyin: 1})
	
  #embeds_many :parameters
  #scope :search_name, lambda { |name| where(:name => /#{name}/) }
  has_many :makers, :dependent => :destroy
#  before_save :update_name_pinyin
	
protected
	
  def update_name_pinyin
#    self.name_pinyin = Pinyin.t(self.name, '').downcase.to_s 
  end
	
end
