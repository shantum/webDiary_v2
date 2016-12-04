class AddFeedUrlToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :feed_url, :string
  end
end
