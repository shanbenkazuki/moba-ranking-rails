class HeroesController < ApplicationController
  def index
    # 全てのヒーローのtier_img_urlを取得
    @tier_img_urls = Hero.pluck(:tier_img_url)
    render 'index'
  end
end
