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

CSV.foreach(Rails.root.join('db/csv/hero.csv'), headers: true) do |row|
  Hero.create!(
    name_en: row['name_en'],
    name_jp: row['name_jp'],
    role: row['role'],
    tier_img_url: row['tier_img_url']
  )
end