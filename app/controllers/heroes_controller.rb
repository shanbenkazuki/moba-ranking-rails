class HeroesController < ApplicationController
  def index
    @heroes = Hero.select(:tier_img_url, :tier, :name_en).order(:tier)
    @latest_date = HeroRate.maximum(:reference_date)
  end
end
