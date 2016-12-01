class AddUserToUserLinks < ActiveRecord::Migration[5.0]
  def change
    add_reference :user_links, :users, foreign_key: true
    add_reference :user_links, :links, foreign_key: true
  end
end
