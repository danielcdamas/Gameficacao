class AchievementsController < ApplicationController
  def index
    @all_achievements    = Achievement.order(:rarity, :condition_value)
    @earned_achievements = current_user.achievements.to_a
    @earned_ids          = @earned_achievements.map(&:id).to_set
  end
end
