class CreateAdverts < ActiveRecord::Migration[6.0]
  def change
    create_table :adverts do |t|
      t.string :title, null: false, limit: 255
      t.text :description, null: false, limit: 10_000
      t.float :price, null:false

      t.timestamps
    end
    add_index :adverts, :title
  end
end
