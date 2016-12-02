class HomeController < ApplicationController
  def index
    if user_signed_in?
      if UserLink.count > 5
        @recent_links = UserLink.limit(6)
      else
        @recent_links = UserLink.all
      end
    end
  end
end
