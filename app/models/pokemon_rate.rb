class PokemonRate < ApplicationRecord
  belongs_to :pokemon

  validates :reference_date, presence: true
  validates :pokemon_id, uniqueness: { scope: :reference_date }
end