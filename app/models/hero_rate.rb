class HeroRate < ApplicationRecord
  belongs_to :hero

  validates :hero_id, presence: true
  validates :win_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :pick_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :ban_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :reference_date, presence: true
  validates :hero_id, uniqueness: { scope: :reference_date }
end
