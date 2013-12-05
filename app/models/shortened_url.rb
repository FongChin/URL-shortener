require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  attr_accessible :short_url, :long_url, :user_id
  validates :short_url, :uniqueness => true, :presence => true
  validates :user_id, :presence => true

  belongs_to(:submitter,
             :primary_key => :id,
             :foreign_key => :user_id,
             :class_name => "User")

  has_many(:visits,
           :primary_key => :id,
           :foreign_key => :shortened_url_id,
           :class_name => "Visit")


  has_many(:visitors, :through => :visits, :source => :user, :uniq => true)

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.new({ :user_id => user.id,
                       :long_url => long_url,
                       :short_url => self.random_code }).save!
  end

  def self.random_code
    is_unique = false
    until is_unique
      random_str = SecureRandom.urlsafe_base64
      is_unique = ShortenedUrl.select(:short_url).none? do |short_url_obj|
        short_url_obj.short_url == random_str
      end
    end
    random_str
  end

  def num_clicks

  end
end