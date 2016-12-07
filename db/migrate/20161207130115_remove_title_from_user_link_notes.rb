class RemoveTitleFromUserLinkNotes < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_link_notes, :title, :string
  end
end
