class ChangeRefNamesInUserLinks < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_links, :users_id, :user_id
    rename_column :user_links, :links_id, :link_id
  end
end
