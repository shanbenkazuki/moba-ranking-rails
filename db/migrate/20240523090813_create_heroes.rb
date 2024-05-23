class CreateHeroes < ActiveRecord::Migration[7.1]
  def change
    create_table :heroes do |t|
      t.string :name_en, null: false
      t.string :name_jp, null: false
      t.string :role, null: false
      t.string :tier_img_url, null: false

      t.timestamps
    end
    add_index :heroes, :name_en, unique: true
    add_check_constraint :heroes, "role IN ('Fighter', 'Mage', 'Tank', 'Assassin', 'Marksman', 'Support')", name: 'role_check'
  end
end
