module HomeHelper

  def current_user_links
    @user_links = UserLink.where(user_id: current_user.id)
  end

  def current_user_feeds
    @user_feeds = UserFeed.where(user_id: current_user.id)
  end

  def current_user_recent_links
    recent_links = current_user_links.last(12).reverse
  end

  def all_feed_entries
    entries = []

    if current_user_feeds
      current_user_feeds.each do |user_feed|
        user_feed.feed.all_entries.each do |entry|
          entries.push(entry)
        end
      end
      return entries
    else
      false
    end
  end

  def newest_feed_entries
    all_feed_entries.sort_by(&:published).last(10).reverse
  end

end
