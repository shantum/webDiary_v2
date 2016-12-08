class Feed < ApplicationRecord
  has_many :user_feeds
  has_many :feed_entries, dependent: :destroy
  before_validation :get_feed_data, :feed_entries_check, :fill_data
  validates_presence_of :url, :title
  require 'date'

  def all_entries
    self.feed_entries.all
  end

  def latest_entries
    load_entries
    latest_entries = self.all_entries.sort_by { |e| e.published}
    latest_entries = latest_entries.first(5)
  end

  def load_entries
    feed_data = Feedjira::Feed.fetch_and_parse self.url
    feed_entries = feed_data.entries
    entries = []

    feed_entries.each do |entry|
      new_entry = FeedEntry.new
      new_entry.feed = self
      new_entry.title = entry.title
      new_entry.host = feed_data.url
      new_entry.url = entry.url
      new_entry.summary = entry.summary
      new_entry.published = entry.published
      new_entry.author = entry.author
      new_entry.save

      if new_entry.persisted?
        entries.push(new_entry)

      end
    end
    return entries
  end

  private

  def fill_data

    self.title = @feed_data.title
    self.description = (@feed_data.description.nil?)? @feed_data.description : "Description Unavailable"

  end

  def feed_entries_check
    if @feed_data.entries.nil?
      false
    else
      true
    end

  end

  def get_feed_data
    @feed_data = Feedjira::Feed.fetch_and_parse self.url
  end
end


