class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :phone_number
      t.string :first_name
      t.string :family_name
      t.string :first_name_kana
      t.string :family_name_kana
      t.date :birthday
      t.text :introduction
      t.integer :post_number
      t.string :prefecture
      t.string :city
      t.string :house_number
      t.string :building_name
      t.references :user

      t.timestamps
    end
  end
end
