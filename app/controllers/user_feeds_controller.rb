class UserFeedsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_feeds = UserFeed.where(user_id: current_user.id)
  end

  def create
    @url = params[:url]

    if Feed.exists?(url: @url)  #check if feed exists by url
      @feed = Feed.find_by(url: @url) #if yes, then assign @feed to such feed
      if UserFeed.where(feed: @feed, user: current_user ).empty? #check if user_link with same link exists
        @user_feed = UserFeed.create(user: current_user, feed: @feed, category: 'un-defined!') #if not, create a new user_link
      else
        @user_feed = UserFeed.find_by(feed: @feed) #if yes, assign @user_link to such user_link
      end
    else
      @feed = Feed.create(url: @url) #if link does not exist in the table, create a new link
      @user_feed = UserFeed.create(user: current_user, link: @feed, category: 'un-defined!') #since link does not yet exist, user_link cannot exist either
    end
  end

  def load_feed
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
