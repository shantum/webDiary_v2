class UserFeedsController < ApplicationController
  before_action :authenticate_user!

  def index
    require 'open-uri'
    @user_feeds = UserFeed.where(user_id: current_user.id)
    @entries = []

    @user_feeds.each do |user_feed|
      feed_data = Feedjira::Feed.fetch_and_parse user_feed.feed.url
      @entries.push(feed_data.entries)
    end

    return @entries
  end

  def create
    @url = params[:url]

    @feed = Feed.find_or_create_by!(url: @url) unless @url.nil?

    @user_feed = UserFeed.find_or_create_by!(user_id: current_user.id, feed: @feed) unless @feed.nil?
  end

  def load_feed(url)
    require 'rss'
    require 'open-uri'
    @rss_results = []

    @user_links = UserLink.where(user_id: current_user.id)

    @user_links.each do |user_link|
      if user_link.link.feed_url != ""
        @rss_results.push(user_link.link.feed_url)
      end
    end

    @rss_data = []

    @rss_results.each do |rss_url|
      feed_data = []

      if rss_url != nil
        open(rss_url) do |rss|
          feed = RSS::Parser.parse(rss).items[0..5]
          feed_data.push(feed)
        end

        @rss_data.push(feed_data)
      end
    end

    return @rss_data

  end


end
