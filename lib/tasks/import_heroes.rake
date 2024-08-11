require 'csv'

namespace :import do
  desc 'Import Heroes from CSV'
  task heroes: :environment do
    duplicates = []
    added_heroes = []

    CSV.foreach(Rails.root.join('db/csv/hero.csv'), headers: true) do |row|
      begin
        Hero.create!(
          name_en: row['name_en'],
          name_jp: row['name_jp'],
          role: row['role'],
          tier_img_url: row['tier_img_url']
        )
        added_heroes << row['name_en']
      rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid => e
        if e.message.include?('Name en has already been taken')
          duplicates << row['name_en']
        else
          raise e
        end
      end
    end

    if duplicates.any?
      puts "以下のヒーローは重複しているため追加できませんでした:"
      duplicates.each do |name|
        puts "- #{name}"
      end
    end

    if added_heroes.any?
      puts "以下のヒーローが追加されました:"
      added_heroes.each do |name|
        puts "- #{name}"
      end
    end
  end
end