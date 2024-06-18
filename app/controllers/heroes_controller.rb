class HeroesController < ApplicationController
  def index
    @latest_fetched_date = HeroTier.maximum(:rates_fetched_date)
    @roles = Hero.distinct.pluck(:role)
    
    @q = Hero.ransack(params[:q])
    @heroes = @q.result
                .select('heroes.tier_img_url, hero_tiers.tier, heroes.name_en')
                .joins(:hero_tiers)
                .where(hero_tiers: { rates_fetched_date: @latest_fetched_date })
                .order('heroes.name_en')

    @hero_win_rates = HeroRate.where(reference_date: @latest_fetched_date).joins(:hero).order(win_rate: :desc).pluck('heroes.name_jp', :win_rate)
    @hero_pick_rates = HeroRate.where(reference_date: @latest_fetched_date).joins(:hero).order(pick_rate: :desc).pluck('heroes.name_jp', :pick_rate)
    @hero_ban_rates = HeroRate.where(reference_date: @latest_fetched_date).joins(:hero).order(ban_rate: :desc).pluck('heroes.name_jp', :ban_rate)
  end
end
