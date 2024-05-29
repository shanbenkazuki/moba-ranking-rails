namespace :pokemon do
  desc 'Calculate and update Pokemon tiers based on the latest Pokemon rates'
  task calculate_tiers: :environment do
    # 最新のreference_dateを取得
    latest_date = PokemonRate.maximum(:reference_date)

    # 最新のポケモンレートを取得
    latest_pokemon_rates = PokemonRate.where(reference_date: latest_date)

    # 各指標の平均と標準偏差を計算
    win_rate_mean, win_rate_std = calculate_mean_and_std(latest_pokemon_rates, :win_rate)
    pick_rate_mean, pick_rate_std = calculate_mean_and_std(latest_pokemon_rates, :pick_rate)
    ban_rate_mean, ban_rate_std = calculate_mean_and_std(latest_pokemon_rates, :ban_rate)

    # 各ポケモンのtierを計算し、更新
    latest_pokemon_rates.each do |pokemon_rate|
      pokemon = pokemon_rate.pokemon

      if pokemon_rate.win_rate.nil? && pokemon_rate.pick_rate.nil? && pokemon_rate.ban_rate.nil?
        # win_rate, pick_rate, ban_rateのすべてがnilの場合はtierをNULLにする
        tier = nil
      else
        # 各指標のz-scoreを計算
        win_rate_z = z_score(pokemon_rate.win_rate, win_rate_mean, win_rate_std)
        pick_rate_z = z_score(pokemon_rate.pick_rate, pick_rate_mean, pick_rate_std)
        ban_rate_z = z_score(pokemon_rate.ban_rate, ban_rate_mean, ban_rate_std)

        # interactionの計算
        interaction = win_rate_z * pick_rate_z

        # tier_score_zの計算
        tier_score_z = 0.6 * win_rate_z + 0.25 * pick_rate_z + 0.15 * ban_rate_z - 0.2 * interaction

        # tier_score_zに基づいてティアを割り当て
        tier = assign_tier(tier_score_z)
      end

      # PokemonTierレコードを作成または更新
      pokemon_tier = PokemonTier.find_or_initialize_by(pokemon_id: pokemon.id)
      pokemon_tier.tier = tier
      pokemon_tier.rates_fetched_date = latest_date
      pokemon_tier.save!
    end

    puts 'Pokemon tiers updated successfully.'
  end

  def calculate_mean_and_std(pokemon_rates, attribute)
    values = pokemon_rates.pluck(attribute).compact
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