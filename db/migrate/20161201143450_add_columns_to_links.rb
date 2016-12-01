class AddColumnsToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :url, :string
    add_column :links, :title, :string
    add_column :links, :description, :string
    add_column :links, :group, :string
    add_column :links, :embed_code, :string
    add_column :links, :thumbnail, :string
  end
end
