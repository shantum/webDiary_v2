class Feed < ApplicationRecord
  has_many :user_feeds
  has_many :entries
  before_validation :fill_data
  validates_presence_of :url, :title, :description

  def fill_data
    feed_url = self.url

    feed = SimpleRSS.parse open(feed_url)

    if feed_entries_check(feed_url)
      self.title = feed.title
      self.description = (feed.description.nil?)? feed.description : "Description Unavailable"
    else
      false
    end
  end

  def feed_entries_check(url)
    feed = SimpleRSS.parse open(url)

    if feed.entries.empty?
      false
    else
      true
    end
  end
end


