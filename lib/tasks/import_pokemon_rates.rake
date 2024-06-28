require 'csv'

namespace :import do
  desc 'Import Pokemon stats from CSV'
  task pokemon_stats: :environment do
    csv_directory = 'db/csv/pokemon_rates'
    latest_csv_file = Dir.glob("#{csv_directory}/pokemon_rates_*.csv").max_by { |f| File.mtime(f) }

    if latest_csv_file
      date_string = latest_csv_file.match(/pokemon_rates_(\d{4}-\d{2}-\d{2})_\d{6}\.csv/)[1]
      reference_date = Date.parse(date_string)
      latest_pokemon_rate = PokemonRate.order(reference_date: :desc).first

      if latest_pokemon_rate && latest_pokemon_rate.reference_date == reference_date
        puts "Updating data for #{reference_date}."
        PokemonRate.where(reference_date: reference_date).delete_all
      else
        puts "Importing new data for #{reference_date}."
      end

      CSV.foreach(latest_csv_file, headers: true) do |row|
        pokemon = Pokemon.find_by(name_en: row['Pokemon'])

        if pokemon
          pokemon_rate = PokemonRate.new(pokemon_id: pokemon.id, reference_date: reference_date)
          
          pokemon_rate.win_rate = row['win_rate'] == '-' ? nil : row['win_rate']
          pokemon_rate.pick_rate = row['pick_rate'] == '-' ? nil : row['pick_rate']
          pokemon_rate.ban_rate = row['ban_rate'] == '-' ? nil : row['ban_rate']
          
          pokemon_rate.save!
        else
          puts "Pokemon not found: #{row['Pokemon']}"
        end
      end
      puts "Processed Pokemon stats from #{latest_csv_file}"
    else
      puts "No CSV file found in #{csv_directory}"
    end
  end
end