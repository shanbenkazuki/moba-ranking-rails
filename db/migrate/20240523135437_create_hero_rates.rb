class CreateHeroRates < ActiveRecord::Migration[7.1]
  def change
    create_table :hero_rates do |t|
      t.references :hero, null: false, foreign_key: true
      t.float :win_rate
      t.float :pick_rate
      t.float :ban_rate
      t.date :reference_date, null: false

      t.timestamps
    end

    add_index :hero_rates, [:hero_id, :reference_date], unique: true
  end
end
