require 'csv'

namespace :import do
  desc 'Import Pokemons from CSV'
  task pokemons: :environment do
    duplicates = []
    added_pokemons = []

    CSV.foreach(Rails.root.join('db/csv/pokemons.csv'), headers: true) do |row|
      begin
        Pokemon.create!(
          name_en: row['name_en'],
          name_jp: row['name_jp'],
          style: row['style'],
          tier_img_url: row['tier_img_url']
        )
        added_pokemons << row['name_en']
      rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid => e
        if e.message.include?('Name en has already been taken')
          duplicates << row['name_en']
        else
          raise e
        end
      end
    end

    if duplicates.any?
      puts "以下のポケモンは重複しているため追加できませんでした:"
      duplicates.each do |name|
        puts "- #{name}"
      end
    end

    if added_pokemons.any?
      puts "以下のポケモンが追加されました:"
      added_pokemons.each do |name|
        puts "- #{name}"
      end
    end
  end
end