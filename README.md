# データ更新手順

## ローカル環境での更新

### モバイル・レジェンド

1. ヒーローの勝率データをインポート：
   ```
   bundle exec rake import:hero_rates
   ```

2. ヒーローの階級（ティア）を計算：
   ```
   bundle exec rake hero:calculate_tiers
   ```

### ポケモンユナイト

1. ポケモンのステータスデータをインポート：
   ```
   bundle exec rake import:pokemon_stats
   ```

2. ポケモンの階級（ティア）を計算：
   ```
   bundle exec rake pokemon:calculate_tiers
   ```

3. ポケモンの基本情報をインポート：
   ```
   bundle exec rake import:pokemons
   ```

## fly.ioへのデータ更新

ローカル環境でのデータ更新後、以下の手順でfly.ioの環境にデータを反映させます：

1. fly.ioにSSH接続：
   ```
   fly ssh console
   ```

2. モバイル・レジェンドのデータを更新：
   ```
   bundle exec rake import:hero_rates
   bundle exec rake hero:calculate_tiers
   ```

3. ポケモンユナイトのデータを更新：
   ```
   bundle exec rake import:pokemon_stats
   bundle exec rake pokemon:calculate_tiers
   bundle exec rake import:pokemons
   ```

4. SSH接続を終了：
   ```
   exit
   ```
