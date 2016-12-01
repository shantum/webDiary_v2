class UserLinksController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
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
end
