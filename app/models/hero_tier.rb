class HeroTier < ApplicationRecord
  belongs_to :hero

  validates :tier, inclusion: { in: ['S+', 'S', 'A+', 'A', 'B', 'C'] }, allow_nil: true
  validates :rates_fetched_date, presence: true
  validates :hero_id, uniqueness: { scope: :rates_fetched_date }
end
