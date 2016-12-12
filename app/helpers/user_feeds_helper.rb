module UserFeedsHelper

  def link_saved_by_user?(url)
    link = Link.find_by_url(url)
    user_link = UserLink.find_by_link_id(link.id) unless link.nil?

    if user_link
      true
    else
      false
    end
  end
end
