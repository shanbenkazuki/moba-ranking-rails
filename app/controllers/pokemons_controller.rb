class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.where.not(tier: nil).select(:tier_img_url, :tier, :name_en).order(:tier)
    @latest_date = PokemonRate.maximum(:reference_date)
  end
end