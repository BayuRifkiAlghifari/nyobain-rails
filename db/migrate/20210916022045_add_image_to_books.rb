class AddImageToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :image_data, :text
  end
end
