class CreateUserFeedTags < ActiveRecord::Migration[5.0]
  def change
    create_table :user_feed_tags do |t|
      t.belongs_to :user_feed, foreign_key: true
      t.belongs_to :tag, foreign_key: true

      t.timestamps
    end
  end
end
