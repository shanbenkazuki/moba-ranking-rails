# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

# CSV.foreach(Rails.root.join('db/csv/hero.csv'), headers: true) do |row|
#   Hero.create!(
#     name_en: row['name_en'],
#     name_jp: row['name_jp'],
#     role: row['role'],
#     tier_img_url: row['tier_img_url']
#   )
# end

# csv_file_path = 'db/csv/hero_rates/hero_stats_2024-05-19.csv'
# reference_date = Date.parse('2024-05-19')

# CSV.foreach(csv_file_path, headers: true) do |row|
#   HeroRate.create!(
#     hero_id: Hero.find_by(name_en: row['hero']).id,
#     win_rate: row['win_rate'],
#     pick_rate: row['pick_rate'],
#     ban_rate: row['ban_rate'],
#     reference_date: reference_date
#   )
# end

# csv_file_path = 'db/csv/hero_rates/hero_stats_2024-05-14.csv'
# reference_date = Date.parse('2024-05-14')

# CSV.foreach(csv_file_path, headers: true) do |row|
#   HeroRate.create!(
#     hero_id: Hero.find_by(name_en: row['hero']).id,
#     win_rate: row['win_rate'],
#     pick_rate: row['pick_rate'],
#     ban_rate: row['ban_rate'],
#     reference_date: reference_date
#   )
# end

# csv_file_path = 'db/csv/hero_rates/hero_stats_2024-05-08.csv'
# reference_date = Date.parse('2024-05-08')

# CSV.foreach(csv_file_path, headers: true) do |row|
#   HeroRate.create!(
#     hero_id: Hero.find_by(name_en: row['hero']).id,
#     win_rate: row['win_rate'],
#     pick_rate: row['pick_rate'],
#     ban_rate: row['ban_rate'],
#     reference_date: reference_date
#   )
# end

# CSV.foreach(Rails.root.join('db/csv/pokemons.csv'), headers: true) do |row|
#   Pokemon.create!(
#     name_en: row['name_en'],
#     name_jp: row['name_jp'],
#     style: row['style'],
#     tier_img_url: row['tier_img_url']
#   )
# end

csv_file_path = 'db/csv/pokemon_rates/pokemon_stats_2024-05-14_150906.csv'
reference_date = Date.parse('2024-05-14')

CSV.foreach(csv_file_path, headers: true) do |row|
  pokemon = Pokemon.find_by(name_en: row['Pokemon'])
  
  win_rate = row['win_rate'] == '-' ? nil : row['win_rate']
  pick_rate = row['pick_rate'] == '-' ? nil : row['pick_rate']
  ban_rate = row['ban_rate'] == '-' ? nil : row['ban_rate']
  
  PokemonRate.create!(
    pokemon_id: pokemon.id,
    win_rate: win_rate,
    pick_rate: pick_rate,
    ban_rate: ban_rate,
    reference_date: reference_date
  )
end

csv_file_path = 'db/csv/pokemon_rates/pokemon_stats_2024-05-20_171878.csv'
reference_date = Date.parse('2024-05-20')

CSV.foreach(csv_file_path, headers: true) do |row|
  pokemon = Pokemon.find_by(name_en: row['Pokemon'])
  
  win_rate = row['win_rate'] == '-' ? nil : row['win_rate']
  pick_rate = row['pick_rate'] == '-' ? nil : row['pick_rate']
  ban_rate = row['ban_rate'] == '-' ? nil : row['ban_rate']
  
  PokemonRate.create!(
    pokemon_id: pokemon.id,
    win_rate: win_rate,
    pick_rate: pick_rate,
    ban_rate: ban_rate,
    reference_date: reference_date
  )
end