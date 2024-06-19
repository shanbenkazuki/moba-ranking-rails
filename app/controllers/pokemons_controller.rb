class PokemonsController < ApplicationController
  def index
    @latest_fetched_date = PokemonTier.maximum(:rates_fetched_date)
    @styles = Pokemon.distinct.pluck(:style)

    @q = Pokemon.ransack(params[:q])

    @pokemons = @q.result
                    .select('pokemons.tier_img_url, pokemon_tiers.tier, pokemons.name_en')
                    .joins(:pokemon_tiers)
                    .where(pokemon_tiers: { rates_fetched_date: @latest_fetched_date })
                    .order('pokemons.name_en')

    @pokemon_win_rates = PokemonRate.where(reference_date: @latest_fetched_date).joins(:pokemon).order(win_rate: :desc).pluck('pokemons.name_jp', :win_rate)
    @pokemon_pick_rates = PokemonRate.where(reference_date: @latest_fetched_date).joins(:pokemon).order(pick_rate: :desc).pluck('pokemons.name_jp', :pick_rate)
    @pokemon_ban_rates = PokemonRate.where(reference_date: @latest_fetched_date).joins(:pokemon).order(ban_rate: :desc).pluck('pokemons.name_jp', :ban_rate)
  end
end