class Task < ApplicationRecord
  belongs_to :user

  DIFFICULTIES = {
    "facil"     => { xp: 10,  label: "Fácil",     emoji: "⚡", color: "green" },
    "medio"     => { xp: 25,  label: "Médio",     emoji: "🔥", color: "yellow" },
    "dificil"   => { xp: 50,  label: "Difícil",   emoji: "💎", color: "red" },
    "lendario"  => { xp: 100, label: "Lendário",  emoji: "⭐", color: "purple" }
  }.freeze

  CATEGORIES = %w[geral trabalho estudos saude fitness financas pessoal].freeze

  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  validates :difficulty, inclusion: { in: DIFFICULTIES.keys }
  validates :category, inclusion: { in: CATEGORIES }

  scope :completed, -> { where(completed: true) }
  scope :pending,   -> { where(completed: false) }
  scope :recent,    -> { order(created_at: :desc) }
  scope :by_difficulty, ->(d) { where(difficulty: d) }

  before_validation :set_xp_reward, on: :create

  def difficulty_info
    DIFFICULTIES[difficulty] || DIFFICULTIES["facil"]
  end

  def difficulty_label
    difficulty_info[:label]
  end

  def difficulty_color
    difficulty_info[:color]
  end

  def difficulty_emoji
    difficulty_info[:emoji]
  end

  def complete!(user)
    return false if completed?

    transaction do
      update!(completed: true, completed_at: Time.current)
      leveled_up = user.add_xp!(xp_reward)
      user.update_streak!
      AchievementService.check_and_award(user)
      leveled_up
    end
  end

  private

  def set_xp_reward
    self.xp_reward = DIFFICULTIES[difficulty]&.dig(:xp) || 10
  end
end
