module ApplicationHelper
  def difficulty_border_class(difficulty)
    case difficulty
    when "facil"    then "border-green-400 hover:border-green-500"
    when "medio"    then "border-yellow-400 hover:border-yellow-500"
    when "dificil"  then "border-red-400 hover:border-red-500"
    when "lendario" then "border-purple-400 hover:border-purple-500"
    else "border-gray-400"
    end
  end

  def difficulty_badge_class(difficulty)
    case difficulty
    when "facil"    then "bg-green-100 text-green-700 dark:bg-green-900/40 dark:text-green-400"
    when "medio"    then "bg-yellow-100 text-yellow-700 dark:bg-yellow-900/40 dark:text-yellow-400"
    when "dificil"  then "bg-red-100 text-red-700 dark:bg-red-900/40 dark:text-red-400"
    when "lendario" then "bg-purple-100 text-purple-700 dark:bg-purple-900/40 dark:text-purple-400"
    else "bg-gray-100 text-gray-700"
    end
  end

  def color_dot_class(color)
    {
      "purple" => "bg-purple-500",
      "blue"   => "bg-blue-500",
      "green"  => "bg-green-500",
      "orange" => "bg-orange-500",
      "red"    => "bg-red-500",
      "pink"   => "bg-pink-500"
    }[color] || "bg-gray-500"
  end

  def rarity_text_class(rarity)
    case rarity
    when "common"    then "text-gray-500 dark:text-gray-400"
    when "uncommon"  then "text-green-600 dark:text-green-400"
    when "rare"      then "text-blue-600 dark:text-blue-400"
    when "epic"      then "text-purple-600 dark:text-purple-400"
    when "legendary" then "text-yellow-600 dark:text-yellow-400"
    else "text-gray-500"
    end
  end

  def rarity_badge_class(rarity)
    case rarity
    when "common"    then "bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400"
    when "uncommon"  then "bg-green-100 text-green-700 dark:bg-green-900/40 dark:text-green-400"
    when "rare"      then "bg-blue-100 text-blue-700 dark:bg-blue-900/40 dark:text-blue-400"
    when "epic"      then "bg-purple-100 text-purple-700 dark:bg-purple-900/40 dark:text-purple-400"
    when "legendary" then "bg-yellow-100 text-yellow-700 dark:bg-yellow-900/40 dark:text-yellow-400"
    else "bg-gray-100 text-gray-600"
    end
  end

  def rarity_star(rarity)
    case rarity
    when "common"    then "○"
    when "uncommon"  then "◇"
    when "rare"      then "◆"
    when "epic"      then "★"
    when "legendary" then "✦"
    else "○"
    end
  end
end
