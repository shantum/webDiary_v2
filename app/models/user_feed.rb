class UserFeed < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  validates_presence_of :user, :feed
end
