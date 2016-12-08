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
      meta_inspector
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

  def meta_inspector
    @link = MetaInspector.new(self.url.split('#')[0]) #.split('#')

    if @link.response.status == 200
      self.url = @link.untracked_url
      self.title = @link.best_title
      self.description = @link.description
      self.group = @link.host
      self.thumbnail = (@link.images.best) ? @link.images.best : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png"
      set_feed(self.url)
    else
      self.title = 'title could not be loaded by metainspector'
      self.description = 'description could not be loaded by metainspector'
      self.group = 'group could not be loaded by metainspector'
    end
  end

  def set_feed(url)
    feed_url_array = Feedbag.find url

    if feed_url_array.empty?
      false
    else
      feed_url = feed_url_array.first
      if feed_check(feed_url)
        self.feed_url = feed_url
      end
    end

  end

  def feed_check(feed_url)
    feed_data = Feedjira::Feed.fetch_and_parse feed_url

    if feed_data.entries.empty?
      false
    else
      true
    end
  end

end
