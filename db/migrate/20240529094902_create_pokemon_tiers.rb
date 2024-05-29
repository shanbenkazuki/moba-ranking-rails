class CreatePokemonTiers < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemon_tiers do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.string :tier
      t.date :rates_fetched_date

      t.timestamps
    end

    add_check_constraint :pokemon_tiers, "tier IN ('S+', 'S', 'A+', 'A', 'B', 'C', 'EX')", name: 'check_tier_values'
  end
end
