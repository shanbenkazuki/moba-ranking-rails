class PokemonTier < ApplicationRecord
  belongs_to :pokemon

  validates :pokemon_id, presence: true
  validates :rates_fetched_date, presence: true
  validates :tier, inclusion: { in: ['S+', 'S', 'A+', 'A', 'B', 'C', 'EX'] }, allow_nil: true
end