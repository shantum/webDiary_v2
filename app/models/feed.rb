class Feed < ApplicationRecord
  has_many :user_feeds
  validates_presence_of :url
end
