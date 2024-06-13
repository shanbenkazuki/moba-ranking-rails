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
  end
end
