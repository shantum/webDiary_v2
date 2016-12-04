class UserLinksController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:tag]
      @user_links = UserLink.where(user_id: current_user.id).tagged_with(params[:tag])
    else
      @user_links = UserLink.where(user_id: current_user.id)
    end
  end

  def create
    @url = params[:url]

    if Link.exists?(url: @url)  #check if link exists by url
      @link = Link.find_by(url: @url) #if yes, then assign @link to such link
      if UserLink.where(link: @link, user: current_user ).empty? #check if user_link with same link exists
        @user_link = UserLink.create(user: current_user, link: @link, category: 'un-defined!') #if not, create a new user_link
      else
        @user_link = UserLink.find_by(link: @link) #if yes, assign @user_link to such user_link
      end
    else
      @link = Link.create(url: @url) #if link does not exist in the table, create a new link
      @user_link = UserLink.create(user: current_user, link: @link, category: 'un-defined!') #since link does not yet exist, user_link cannot exist either
    end # Non-duplication conditions

    render :view
  end

  def edit
    @user_link = UserLink.find(params[:id])
    render :edit
  end

  def view
    @user_link = UserLink.find(params[:id])
    render :view
  end

  def delete
    @user_link = UserLink.find(params[:id])
    @user_link.delete
    @user_links = UserLink.where(user: current_user)
    redirect_to '/'
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

  def add_tag
    @tag_name = params[:tag_name]
    @user_link_id = params[:user_link_id].to_i
    @user_link = UserLink.find(@user_link_id)
    @user_link.add_tag(@tag_name)
  end
end
