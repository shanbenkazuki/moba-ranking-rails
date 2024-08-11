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

## fly.ioへのデータ更新

ローカル環境でのデータ更新後、以下の手順でfly.ioの環境にデータを反映させます：

0. 新規CSVをプッシュ後、デプロイ:
   ```
   fly deploy
   ```

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
   ```

4. SSH接続を終了：
   ```
   exit
   ```

## 新規キャラクターの追加

### ポケモンユナイト

1. db/csv/pokemons.csvに追加

2. ポケモン情報を更新
   ```
   bundle exec rake import:pokemons
   ```

### モバイル・レジェンド

1. db/csv/hero.csvに追加

2. ヒーロー情報を更新
   ```
   bundle exec rake import:heroes
   ```