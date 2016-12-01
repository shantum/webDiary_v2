class HomeController < ApplicationController
  def index
    if user_signed_in?
      if UserLink.count > 3
        @recent_links = UserLink.order(created_at: :desc).last(3)
      else
        @recent_links = UserLink.all.reverse_order
      end
    end
  end
end
