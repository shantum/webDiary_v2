class HomeController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js
  include HomeHelper

  def index
    @user_feeds = UserFeed.where(user_id: current_user.id)
  end
end
