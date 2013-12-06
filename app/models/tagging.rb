class Tagging < ActiveRecord::Base
  attr_accessible :shortened_url_id, :tag_topic_id

  validates :shortened_url_id, :tag_topic_id, :presence => true

  belongs_to(:tag_topic,
             :primary_key => :id,
             :foreign_key => :tag_topic_id,
             :class_name => "TagTopic")

  belongs_to(:url,
             :primary_key => :id,
             :foreign_key => :shortened_url_id,
             :class_name => "ShortenedUrl")

  def self.create_tagging(shortened_url_id, tag_topic_id)
    Tagging.new({:shortened_url_id => shortened_url_id,
                 :tag_topic_id => tag_topic_id}).save!
  end
end