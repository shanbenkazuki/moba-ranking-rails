class PokemonsController < ApplicationController
  def index
    @latest_fetched_date = PokemonTier.maximum(:rates_fetched_date)
    @pokemons = Pokemon.select('pokemons.tier_img_url, pokemon_tiers.tier, pokemons.name_en')
                       .joins(:pokemon_tiers)
                       .where(pokemon_tiers: { rates_fetched_date: @latest_fetched_date })
                       .order('pokemons.name_en')
  end
end