class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      if UserLink.count > 5
        @recent_links = UserLink.limit(6)
      else
        @recent_links = UserLink.all
      end
    end

    require 'open-uri'
    @user_feeds = UserFeed.where(user_id: current_user.id)
    @entries = []

    # @user_feeds.each do |user_feed|
    #   feed_data = Feedjira::Feed.fetch_and_parse user_feed.feed.url
    #   @entries.push(feed_data.entries)
    # end

    return @entries

  end
end
