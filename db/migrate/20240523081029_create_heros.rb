class CreateHeros < ActiveRecord::Migration[7.1]
  def change
    create_table :heros do |t|
      t.string :name_en, null: false
      t.string :name_jp, null: false
      t.string :role, null: false
      t.string :tier_img_url, null: false

      t.timestamps
    end
    add_index :heros, :name_en, unique: true
    add_check_constraint :heros, "role IN ('Fighter', 'Mage', 'Tank', 'Assassin', 'Marksman', 'Support')", name: 'role_check'
  end
end
