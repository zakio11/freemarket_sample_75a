class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.string :shipment_date, null: false
      t.string :shipment_pref, null: false
      t.references :category, null: false, foreign_key: true
      t.string :brand, null: false
      t.string :item_status, null: false
      t.string :shipment_fee, null: false
      # t.references :seller, null: false, foreign_key: true
      # t.references :buyer, foreign_key: true
      # t.string :prefecture, null: false
    end
  end
end
