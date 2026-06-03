class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy
  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  LEVELS = [
    { level: 1,  xp_required: 0 },
    { level: 2,  xp_required: 100 },
    { level: 3,  xp_required: 250 },
    { level: 4,  xp_required: 500 },
    { level: 5,  xp_required: 850 },
    { level: 6,  xp_required: 1300 },
    { level: 7,  xp_required: 1900 },
    { level: 8,  xp_required: 2700 },
    { level: 9,  xp_required: 3700 },
    { level: 10, xp_required: 5000 },
    { level: 15, xp_required: 10000 },
    { level: 20, xp_required: 20000 },
    { level: 25, xp_required: 35000 },
    { level: 30, xp_required: 55000 },
    { level: 40, xp_required: 100000 },
    { level: 50, xp_required: 175000 }
  ].freeze

  THEMES = %w[dark light].freeze
  COLOR_THEMES = %w[purple blue green orange red pink].freeze

  def xp_for_current_level
    current = LEVELS.select { |l| l[:level] <= level }.last
    current ? current[:xp_required] : 0
  end

  def xp_for_next_level
    next_lvl = LEVELS.find { |l| l[:level] > level }
    next_lvl ? next_lvl[:xp_required] : xp_for_current_level + 10000
  end

  def xp_progress_percent
    current_xp = xp - xp_for_current_level
    needed_xp = xp_for_next_level - xp_for_current_level
    return 100 if needed_xp <= 0
    [ (current_xp.to_f / needed_xp * 100).round, 100 ].min
  end

  def xp_to_next_level
    [ xp_for_next_level - xp, 0 ].max
  end

  def add_xp!(amount)
    old_level = level
    increment!(:xp, amount)
    update_level!
    level > old_level
  end

  def update_streak!
    today = Date.current
    if last_activity_date == today - 1
      increment!(:streak_days)
    elsif last_activity_date != today
      update!(streak_days: 1)
    end
    update!(last_activity_date: today)
  end

  def completed_tasks_count
    tasks.completed.count
  end

  def pending_tasks_count
    tasks.pending.count
  end

  def title
    case level
    when 1..2   then "Iniciante"
    when 3..5   then "Aventureiro"
    when 6..9   then "Herói"
    when 10..14 then "Campeão"
    when 15..19 then "Lenda"
    when 20..29 then "Mestre"
    when 30..39 then "Grão-Mestre"
    when 40..49 then "Imortal"
    else             "Deus"
    end
  end

  private

  def update_level!
    new_level = LEVELS.select { |l| xp >= l[:xp_required] }.last&.dig(:level) || 1
    update_column(:level, new_level) if new_level != level
  end
end
