class FeedEntry < ApplicationRecord
  belongs_to :feed, dependent: :destroy
  before_save :strip_summary_tags
  validates_presence_of :title, :published, :feed, :host, :url
  validates :url, uniqueness: true

  def strip_summary_tags
    full_sanitizer = Rails::Html::FullSanitizer.new

    self.summary = full_sanitizer.sanitize(self.summary)
  end


end
