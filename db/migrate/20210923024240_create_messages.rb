class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :sender
      t.references :receiver
      t.references :room
      t.text :message
      t.text :attachment
      t.timestamps
    end
  end
end
