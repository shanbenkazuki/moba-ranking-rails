require 'csv'

namespace :import do
  desc 'Import Hero rates from CSV'
  task hero_rates: :environment do
    csv_directory = 'db/csv/hero_rates'
    latest_csv_file = Dir.glob("#{csv_directory}/hero_rates_*.csv").max_by { |f| File.mtime(f) }

    if latest_csv_file
      date_string = latest_csv_file.match(/hero_rates_(\d{4}-\d{2}-\d{2})\.csv/)[1]
      reference_date = Date.parse(date_string)
      latest_hero_rate = HeroRate.order(reference_date: :desc).first

      if latest_hero_rate && latest_hero_rate.reference_date == reference_date
        puts "Updating data for #{reference_date}."
        HeroRate.where(reference_date: reference_date).delete_all
      else
        puts "Importing new data for #{reference_date}."
      end

      CSV.foreach(latest_csv_file, headers: true) do |row|
        hero = Hero.find_by(name_en: row['hero'])

        if hero
          hero_rate = HeroRate.new(hero_id: hero.id, reference_date: reference_date)
          
          hero_rate.win_rate = row['win_rate'] == '-' ? nil : row['win_rate']
          hero_rate.pick_rate = row['pick_rate'] == '-' ? nil : row['pick_rate']
          hero_rate.ban_rate = row['ban_rate'] == '-' ? nil : row['ban_rate']
          
          hero_rate.save!
        else
          puts "Hero not found: #{row['hero']}"
        end
      end
      puts "Processed Hero rates from #{latest_csv_file}"
    else
      puts "No CSV file found in #{csv_directory}"
    end
  end
end