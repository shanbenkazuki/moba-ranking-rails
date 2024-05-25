class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name_en, null: false
      t.string :name_jp, null: false
      t.string :style, null: false
      t.string :tier_img_url, null: false
      t.string :tier

      t.timestamps
    end

    add_index :pokemons, :name_en, unique: true
    add_check_constraint :pokemons, "style IN ('All-Rounder', 'Supporter', 'Attacker', 'Defender', 'Speedster')", name: 'valid_style'
  end
end