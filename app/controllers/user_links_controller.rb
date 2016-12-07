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

    @link = Link.find_or_create_by!(url: @url)

    @user_link = UserLink.find_or_create_by!(user: current_user, link: @link)

    # if Link.exists?(url: @url)  #check if link exists by url
    #   @link = Link.find_by(url: @url) #if yes, then assign @link to such link
    #   if UserLink.where(link: @link, user: current_user ).empty? #check if user_link with same link exists
    #     @user_link = UserLink.create!(user: current_user, link: @link, category: 'un-defined!') #if not, create a new user_link
    #   else
    #     @user_link = UserLink.find_by(link: @link) #if yes, assign @user_link to such user_link
    #   end
    # else
    #   @link = Link.create!(url: @url) #if link does not exist in the table, create a new link
    #   @user_link = UserLink.create!(user: current_user, link: @link, category: 'un-defined!') #since link does not yet exist, user_link cannot exist either
    # end # Non-duplication conditions

    render :view
  end

  def edit
    @user_link = UserLink.find(params[:id])
  end

  def view
    @user_link = UserLink.find(params[:id])
  end

  def delete
    @user_link = UserLink.find(params[:id])
    @user_link.delete
    @user_links = UserLink.where(user: current_user)
    redirect_to '/'
  end

  def add_tag
    @user_link_id = params[:user_link_id].to_i
    @user_link = UserLink.find(@user_link_id)

    @tag_names = params[:tag_name].split(',')
    @tag_names.each do |name|
      name = name.delete(' ')
      @user_link.add_tag(name)
    end

    redirect_to '/'
  end

  def add_feed
    @url = params[:url]

    @feed = Feed.find_or_create_by!(url: @url)
    @user_feed = UserFeed.find_or_create_by!(feed: @feed)

    redirect_to '/'
  end

  def add_note
    content = params[:content]
    user_link_id = params[:user_link_id]
    user_link = UserLink.find(user_link_id)
    note = user_link.add_note(content)
    redirect_to '/'
  end
end
