namespace :hero do
  desc 'Calculate and update hero tiers based on the latest hero rates'
  task calculate_tiers: :environment do
    # 最新のreference_dateを取得
    latest_date = HeroRate.maximum(:reference_date)

    # 最新のヒーローレートを取得
    latest_hero_rates = HeroRate.where(reference_date: latest_date)

    # 各指標の平均と標準偏差を計算
    win_rate_mean, win_rate_std = calculate_mean_and_std(latest_hero_rates, :win_rate)
    pick_rate_mean, pick_rate_std = calculate_mean_and_std(latest_hero_rates, :pick_rate)
    ban_rate_mean, ban_rate_std = calculate_mean_and_std(latest_hero_rates, :ban_rate)

    # 各ヒーローのtierを計算し、更新
    latest_hero_rates.each do |hero_rate|
      hero = hero_rate.hero

      # 各指標のz-scoreを計算
      win_rate_z = z_score(hero_rate.win_rate, win_rate_mean, win_rate_std)
      pick_rate_z = z_score(hero_rate.pick_rate, pick_rate_mean, pick_rate_std)
      ban_rate_z = z_score(hero_rate.ban_rate, ban_rate_mean, ban_rate_std)

      # interactionの計算
      interaction = win_rate_z * pick_rate_z

      # tier_score_zの計算
      tier_score_z = 0.6 * win_rate_z + 0.25 * pick_rate_z + 0.15 * ban_rate_z - 0.2 * interaction

      # tier_score_zに基づいてティアを割り当て
      hero.tier = assign_tier(tier_score_z)
      hero.save!
    end

    puts 'Hero tiers updated successfully.'
  end

  def calculate_mean_and_std(hero_rates, attribute)
    values = hero_rates.pluck(attribute).compact
    return [0, 0] if values.empty?

    mean = values.sum / values.size.to_f
    variance = values.sum { |value| (value - mean)**2 } / (values.size - 1).to_f
    std = Math.sqrt(variance)

    [mean, std]
  end

  def z_score(value, mean, std)
    return 0 if std.zero?
    (value - mean) / std
  end

  def assign_tier(score)
    case score
    when 1.0..Float::INFINITY then 'S+'
    when 0.5...1.0 then 'S'
    when 0.0...0.5 then 'A+'
    when -0.5...0.0 then 'A'
    when -1.0...-0.5 then 'B'
    else 'C'
    end
  end
end