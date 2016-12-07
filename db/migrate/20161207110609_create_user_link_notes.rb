class CreateUserLinkNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_link_notes do |t|
      t.string :title
      t.text :content
      t.belongs_to :UserLink, foreign_key: true

      t.timestamps
    end
  end
end
