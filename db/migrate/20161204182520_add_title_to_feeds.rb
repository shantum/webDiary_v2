class AddTitleToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :title, :string
    add_column :feeds, :description, :text
  end
end
