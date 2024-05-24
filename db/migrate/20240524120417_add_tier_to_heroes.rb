class AddTierToHeroes < ActiveRecord::Migration[7.1]
  def change
    add_column :heroes, :tier, :string
    add_check_constraint :heroes, "tier IN ('S+', 'S', 'A+', 'A', 'B', 'C')", name: 'check_tier_values'
  end
end