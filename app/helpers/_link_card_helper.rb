module LinkCardHelper

  def user_feed_check(user_link)
    if user_link.link.feed_url.nil?
      false
    else
      @feed = Feed.find_by_url(user_link.link.feed_url)
      @user_feed = UserFeed.where(:user_id => current_user.id, :feed_id => @feed.id) unless @feed.nil?
      if @user_feed
        false
      else
        true
      end
    end
  end

end