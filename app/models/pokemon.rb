class Pokemon < ApplicationRecord
    has_many :pokemon_rates, dependent: :destroy
    has_many :pokemon_tiers, dependent: :destroy

    VALID_STYLES = ['All-Rounder', 'Supporter', 'Attacker', 'Defender', 'Speedster'].freeze
  
    validates :name_en, presence: true, uniqueness: true
    validates :name_jp, presence: true
    validates :style, presence: true, inclusion: { in: VALID_STYLES }
    validates :tier_img_url, presence: true

    def self.ransackable_attributes(auth_object = nil)
      ["style"]
    end
  end
