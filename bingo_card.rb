# ビンゴカードの２次元配列（columnsを基準にする）
def build_bingo_card(lines)
  build_card = lines.map! do |line|
    line.map do |number|
      number.to_s.rjust(2)
    end
  end
  build_card[2][2] = "  "
  return build_card
end

# 新しいcolumnsの生成
def new_create_line(display_lines)
  # 文字列を配列化
  new_lines = display_lines.map { |line| line.split(/[|]/)}
  return  new_lines
end

# 番号の照合
def checked_lines(check_lines,select_number)
  checked_cards = check_lines.map do |line|
    line.map! do |number|
      if number == select_number
        number = nil
      else
        number
      end
    end
  end
  return checked_cards
end

# カード表示用の処理
def checked_numbers(check_lines,select_number)
  checked_cards = check_lines.map do |line|
    line.map! do |number|
      if number == select_number
        number = "  "
      else
        number
      end
    end
  end
  return checked_cards
end

# リーチの判定
def check_reach_line(lines, bool_value)
  lines.each do |check_line|
    check_line.compact!
    if check_line.size == 1
      bool_value = true
    end
  end
  puts "リーチです"  if bool_value
end
