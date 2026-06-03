class Achievement < ApplicationRecord
  has_many :user_achievements, dependent: :destroy
  has_many :users, through: :user_achievements

  RARITIES = %w[common uncommon rare epic legendary].freeze

  validates :name, presence: true
  validates :description, presence: true
  validates :icon, presence: true
  validates :condition_type, presence: true
  validates :condition_value, numericality: { greater_than: 0 }
  validates :rarity, inclusion: { in: RARITIES }

  def rarity_color
    case rarity
    when "common"    then "gray"
    when "uncommon"  then "green"
    when "rare"      then "blue"
    when "epic"      then "purple"
    when "legendary" then "yellow"
    end
  end
end
