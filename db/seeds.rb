achievements_data = [
  # Tasks completed
  { name: "Primeira Missão",     description: "Complete sua primeira tarefa",          icon: "🎯", condition_type: "tasks_completed", condition_value: 1,   xp_bonus: 50,   rarity: "common" },
  { name: "Começando Bem",       description: "Complete 5 tarefas",                    icon: "⚡", condition_type: "tasks_completed", condition_value: 5,   xp_bonus: 100,  rarity: "common" },
  { name: "Em Ritmo",            description: "Complete 10 tarefas",                   icon: "🔥", condition_type: "tasks_completed", condition_value: 10,  xp_bonus: 200,  rarity: "uncommon" },
  { name: "Produtivo",           description: "Complete 25 tarefas",                   icon: "💪", condition_type: "tasks_completed", condition_value: 25,  xp_bonus: 350,  rarity: "uncommon" },
  { name: "Máquina de Tarefas",  description: "Complete 50 tarefas",                   icon: "🤖", condition_type: "tasks_completed", condition_value: 50,  xp_bonus: 500,  rarity: "rare" },
  { name: "Centenário",          description: "Complete 100 tarefas",                  icon: "💯", condition_type: "tasks_completed", condition_value: 100, xp_bonus: 1000, rarity: "epic" },
  { name: "Lenda Viva",          description: "Complete 500 tarefas",                  icon: "🏆", condition_type: "tasks_completed", condition_value: 500, xp_bonus: 5000, rarity: "legendary" },

  # Streaks
  { name: "Consistente",         description: "Mantenha uma sequência de 3 dias",      icon: "📅", condition_type: "streak_days",     condition_value: 3,   xp_bonus: 75,   rarity: "common" },
  { name: "Semana Perfeita",     description: "Mantenha uma sequência de 7 dias",      icon: "🗓️", condition_type: "streak_days",     condition_value: 7,   xp_bonus: 200,  rarity: "uncommon" },
  { name: "Imparável",           description: "Mantenha uma sequência de 30 dias",     icon: "🌟", condition_type: "streak_days",     condition_value: 30,  xp_bonus: 1000, rarity: "rare" },
  { name: "Dedicação Total",     description: "Mantenha uma sequência de 100 dias",    icon: "👑", condition_type: "streak_days",     condition_value: 100, xp_bonus: 5000, rarity: "legendary" },

  # Levels
  { name: "Evoluindo",           description: "Alcance o nível 5",                     icon: "⬆️", condition_type: "level_reached",   condition_value: 5,   xp_bonus: 100,  rarity: "common" },
  { name: "Herói Emergente",     description: "Alcance o nível 10",                    icon: "🦸", condition_type: "level_reached",   condition_value: 10,  xp_bonus: 500,  rarity: "rare" },
  { name: "Mestre Supremo",      description: "Alcance o nível 20",                    icon: "🎖️", condition_type: "level_reached",   condition_value: 20,  xp_bonus: 2000, rarity: "legendary" },

  # Difficulty based
  { name: "Corajoso",            description: "Complete 5 tarefas difíceis",            icon: "💎", condition_type: "hard_completed",      condition_value: 5,  xp_bonus: 300,  rarity: "rare" },
  { name: "Lendário",            description: "Complete uma tarefa lendária",            icon: "⭐", condition_type: "legendary_completed", condition_value: 1,  xp_bonus: 200,  rarity: "epic" },
  { name: "Caçador de Lendas",   description: "Complete 10 tarefas lendárias",          icon: "🌠", condition_type: "legendary_completed", condition_value: 10, xp_bonus: 2000, rarity: "legendary" }
]

achievements_data.each do |data|
  Achievement.find_or_create_by!(name: data[:name]) do |a|
    a.description     = data[:description]
    a.icon            = data[:icon]
    a.condition_type  = data[:condition_type]
    a.condition_value = data[:condition_value]
    a.xp_bonus        = data[:xp_bonus]
    a.rarity          = data[:rarity]
  end
end

puts "✅ #{Achievement.count} conquistas criadas"

if Rails.env.development?
  user = User.find_or_create_by!(email: "demo@gameficacao.com") do |u|
    u.name     = "Jogador Demo"
    u.password = "demo123456"
  end

  Task::DIFFICULTIES.each_key do |difficulty|
    Task.find_or_create_by!(title: "Tarefa #{difficulty.capitalize} de exemplo", user: user) do |t|
      t.difficulty = difficulty
      t.category   = "geral"
      t.description = "Esta é uma tarefa de exemplo para demonstrar a dificuldade #{difficulty}."
    end
  end

  puts "✅ Usuário demo criado: demo@gameficacao.com / demo123456"
end
