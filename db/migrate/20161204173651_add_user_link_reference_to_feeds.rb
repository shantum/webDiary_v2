class AddUserLinkReferenceToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :user_link, :reference
  end
end
