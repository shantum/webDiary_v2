class Tag < ApplicationRecord
  has_many :user_link_tags
  has_many :user_links, through: :user_link_tags
  validates_presence_of :name
end
