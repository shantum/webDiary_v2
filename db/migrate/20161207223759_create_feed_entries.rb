class CreateFeedEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_entries do |t|
      t.string :title
      t.string :host
      t.string :url
      t.string :author
      t.text :summary
      t.belongs_to :feed, foreign_key: true
      t.datetime :published

      t.timestamps
    end
  end
end
