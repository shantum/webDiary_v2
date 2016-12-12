class UserFeed < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  validates_presence_of :user, :feed_id

  def feed
    feed = Feed.find(self.feed_id)
  end

end
