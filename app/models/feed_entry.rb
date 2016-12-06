class FeedEntry < ApplicationRecord
  belongs_to :feed, dependent: :destroy
  validates_presence_of :title, :description, :date, :author, :feed

  def create
    FeedEntry.create(feed_entry_params)
  end


  entry = FeedEntry

  private

  def feed_entry_params
    params.require(:feed_entry).permit(:title, :description, :date, :author, :feed)
  end


end
