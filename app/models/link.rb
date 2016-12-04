class Link < ApplicationRecord
  has_many :user_links
  before_validation :fill_data
  validates_presence_of :url, :title, :description, :group
  require 'open-uri'
  Yt.configuration.api_key = "AIzaSyCJDSSvbe4lz8h-ZWW6bYxQGkJBD6N5ltE"

  def fill_data
    # Define regex rules for identification of source
    @youtube_regex = /^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/

    if @youtube_regex.match(self.url)
      youtube
    else
      @link = MetaInspector.new(self.url.split('#')[0]) #.split('#')
      if @link.response.status == 200
        self.url = @link.untracked_url
        self.title = @link.best_title
        self.description = @link.description
        self.group = @link.host
        self.thumbnail = @link.images.best
        self.feed_url = (@link.feed) ? @link.feed : ''
      else
        self.title = 'title could not be loaded by metainspector'
        self.description = 'description could not be loaded by metainspector'
        self.group = 'group could not be loaded by metainspector'

      end
    end
  end

  def youtube
    @video = Yt::Video.new url: url
    self.title = @video.title
    self.description = @video.description
    self.group = 'youtube video'
    self.embed_code = @video.embed_html
    self.thumbnail = @video.thumbnail_url
  end

end
