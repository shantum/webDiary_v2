class UserLink < ApplicationRecord
  belongs_to :user
  belongs_to :link
  validates_presence_of :user, :link, :user_id, :link_id
end
