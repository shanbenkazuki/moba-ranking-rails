class Hero < ApplicationRecord
    validates :name_en, presence: true, uniqueness: true
    validates :name_jp, presence: true
    validates :role, presence: true, inclusion: { in: ['Fighter', 'Mage', 'Tank', 'Assassin', 'Marksman', 'Support'] }
    validates :tier_img_url, presence: true
end