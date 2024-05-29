class AddIsExToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :is_EX, :boolean, default: false, null: false
  end
end
