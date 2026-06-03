class AchievementService
  def self.check_and_award(user)
    new(user).check_and_award
  end

  def initialize(user)
    @user = user
  end

  def check_and_award
    earned = []
    Achievement.all.each do |achievement|
      next if @user.achievements.include?(achievement)
      next unless condition_met?(achievement)

      user_achievement = UserAchievement.create!(
        user: @user,
        achievement: achievement,
        earned_at: Time.current
      )
      @user.add_xp!(achievement.xp_bonus) if achievement.xp_bonus > 0
      earned << achievement
    end
    earned
  end

  private

  def condition_met?(achievement)
    case achievement.condition_type
    when "tasks_completed"
      @user.tasks.completed.count >= achievement.condition_value
    when "streak_days"
      @user.streak_days >= achievement.condition_value
    when "level_reached"
      @user.level >= achievement.condition_value
    when "xp_earned"
      @user.xp >= achievement.condition_value
    when "legendary_completed"
      @user.tasks.completed.by_difficulty("lendario").count >= achievement.condition_value
    when "hard_completed"
      @user.tasks.completed.by_difficulty("dificil").count >= achievement.condition_value
    else
      false
    end
  end
end
