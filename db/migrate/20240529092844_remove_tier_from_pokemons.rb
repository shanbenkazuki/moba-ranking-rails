class RemoveTierFromPokemons < ActiveRecord::Migration[7.1]
  def change
    remove_column :pokemons, :tier, :string
  end
end
