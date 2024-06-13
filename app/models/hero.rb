class Hero < ApplicationRecord
    has_many :hero_rates, dependent: :destroy
    has_many :hero_tiers, dependent: :destroy

    validates :name_en, presence: true, uniqueness: true
    validates :name_jp, presence: true
    validates :role, presence: true, inclusion: { in: ['Fighter', 'Mage', 'Tank', 'Assassin', 'Marksman', 'Support'] }
    validates :tier_img_url, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["role"]
    end
end
