require 'csv'

namespace :import do
  desc 'Import Pokemon stats from CSV'
  task pokemon_stats: :environment do
    # CSVファイルのディレクトリを指定
    csv_directory = 'db/csv/pokemon_rates'

    # 最新のCSVファイルを取得
    latest_csv_file = Dir.glob("#{csv_directory}/pokemon_rates_*.csv").max_by { |f| File.mtime(f) }

    # CSVファイルが存在する場合にインポートを実行
    if latest_csv_file
      # ファイル名から日付を抽出
      date_string = latest_csv_file.match(/pokemon_rates_(\d{4}-\d{2}-\d{2})_\d{6}\.csv/)[1]
      reference_date = Date.parse(date_string)

      # 最新のPokemonRateレコードの日付を取得
      latest_pokemon_rate = PokemonRate.order(reference_date: :desc).first

      # CSVファイルの日付が最新のPokemonRateレコードの日付と一致する場合はスキップ
      if latest_pokemon_rate && latest_pokemon_rate.reference_date == reference_date
        puts "Data for #{reference_date} already exists. Skipping import."
      else
        CSV.foreach(latest_csv_file, headers: true) do |row|
          # PokemonモデルからPokemon名に一致するレコードを取得
          pokemon = Pokemon.find_by(name_en: row['Pokemon'])

          if pokemon
            # PokemonRateレコードを作成
            pokemon_rate = PokemonRate.new(pokemon_id: pokemon.id, reference_date: reference_date)
            
            # win_rateが'-'の場合はNULLを設定
            if row['win_rate'] == '-'
              pokemon_rate.win_rate = nil
            else
              pokemon_rate.win_rate = row['win_rate']
            end
            
            # pick_rateが'-'の場合はNULLを設定
            if row['pick_rate'] == '-'
              pokemon_rate.pick_rate = nil
            else
              pokemon_rate.pick_rate = row['pick_rate']
            end
            
            # ban_rateが'-'の場合はNULLを設定
            if row['ban_rate'] == '-'
              pokemon_rate.ban_rate = nil
            else
              pokemon_rate.ban_rate = row['ban_rate']
            end
            
            pokemon_rate.save!
          else
            puts "Pokemon not found: #{row['Pokemon']}"
          end
        end
        puts "Imported Pokemon stats from #{latest_csv_file}"
      end
    else
      puts "No CSV file found in #{csv_directory}"
    end
  end
end