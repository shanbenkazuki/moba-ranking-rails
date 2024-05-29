class RemoveTierFromHeroes < ActiveRecord::Migration[7.1]
  def change
    remove_check_constraint :heroes, name: "check_tier_values"
    remove_column :heroes, :tier
  end
end
