class ChamgeTitleToTipeRoom < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :type, :tipe
  end
end
