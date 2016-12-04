class UserFeedTag < ApplicationRecord
  belongs_to :user_feed
  belongs_to :tag
end
