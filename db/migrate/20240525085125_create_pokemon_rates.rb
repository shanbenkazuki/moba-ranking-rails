class CreatePokemonRates < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemon_rates do |t|
      t.float :win_rate
      t.float :pick_rate
      t.float :ban_rate
      t.date :reference_date, null: false
      t.references :pokemon, null: false, foreign_key: true

      t.timestamps
    end

    add_index :pokemon_rates, [:pokemon_id, :reference_date], unique: true
  end
end