class CreateHeroTiers < ActiveRecord::Migration[7.1]
  def change
    create_table :hero_tiers do |t|
      t.references :hero, null: false, foreign_key: true
      t.string :tier
      t.date :rates_fetched_date, null: false

      t.timestamps
    end

    add_check_constraint :hero_tiers, "tier IN ('S+', 'S', 'A+', 'A', 'B', 'C')", name: 'check_tier_values'
    add_index :hero_tiers, [:hero_id, :rates_fetched_date], unique: true
  end
end
