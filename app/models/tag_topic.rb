class TagTopic < ActiveRecord::Base
  attr_accessible :tag

  validates :tag, :uniqueness => true, :presence => true

  has_many(:taggings,
           :primary_key => :id,
           :foreign_key => :tag_topic_id,
           :class_name => "Tagging" )

  has_many(:urls, :through => :taggings, :source => :url)


end