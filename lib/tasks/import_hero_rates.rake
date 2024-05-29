require 'csv'

namespace :import do
  desc 'Import Hero rates from CSV'
  task hero_rates: :environment do
    # CSVファイルのディレクトリを指定
    csv_directory = 'db/csv/hero_rates'

    # 最新のCSVファイルを取得
    latest_csv_file = Dir.glob("#{csv_directory}/hero_rates_*.csv").max_by { |f| File.mtime(f) }

    # CSVファイルが存在する場合にインポートを実行
    if latest_csv_file
      # ファイル名から日付を抽出
      date_string = latest_csv_file.match(/hero_rates_(\d{4}-\d{2}-\d{2})\.csv/)[1]
      reference_date = Date.parse(date_string)

      # 最新のHeroRateレコードの日付を取得
      latest_hero_rate = HeroRate.order(reference_date: :desc).first

      # CSVファイルの日付が最新のHeroRateレコードの日付と一致する場合はスキップ
      if latest_hero_rate && latest_hero_rate.reference_date == reference_date
        puts "Data for #{reference_date} already exists. Skipping import."
      else
        CSV.foreach(latest_csv_file, headers: true) do |row|
          # HeroモデルからHero名に一致するレコードを取得
          hero = Hero.find_by(name_en: row['hero'])

          if hero
            # HeroRateレコードを作成
            hero_rate = HeroRate.new(hero_id: hero.id, reference_date: reference_date)
            
            # win_rateが'-'の場合はNULLを設定
            if row['win_rate'] == '-'
              hero_rate.win_rate = nil
            else
              hero_rate.win_rate = row['win_rate']
            end
            
            # pick_rateが'-'の場合はNULLを設定
            if row['pick_rate'] == '-'
              hero_rate.pick_rate = nil
            else
              hero_rate.pick_rate = row['pick_rate']
            end
            
            # ban_rateが'-'の場合はNULLを設定
            if row['ban_rate'] == '-'
              hero_rate.ban_rate = nil
            else
              hero_rate.ban_rate = row['ban_rate']
            end
            
            hero_rate.save!
          else
            puts "Hero not found: #{row['hero']}"
          end
        end
        puts "Imported Hero rates from #{latest_csv_file}"
      end
    else
      puts "No CSV file found in #{csv_directory}"
    end
  end
end