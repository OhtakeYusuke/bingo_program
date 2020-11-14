
b = (1..15).to_a.shuffle.take(5)
i = (16..30).to_a.shuffle.take(5)
n = (31..45).to_a.shuffle.take(5)
g = (46..60).to_a.shuffle.take(5)
o = (61..75).to_a.shuffle.take(5)

lines = [b, i, n, g, o]
columns = lines.transpose
columns[2][2] = nil
lines[2][2] = nil

pre_cards = columns.map do |pre_card|
  pre_card.map do |number|
    number.to_s.rjust(2)
  end
end


# 縦と横の中央の穴あけ
lines = lines.map do |pre_line|
  pre_line.map do |number|
    number.to_s.rjust(2)
  end
end
lines[2][2] = nil

columns = columns.map do |pre_column|
  pre_column.map do |number|
    number.to_s.rjust(2)
  end
end
columns[2][2] = nil




cards = pre_cards.map! do |card|
  card.join("|")
end

puts cards
puts "~~~~~~~~~~~~~~~~~"


check_continue = 1
already_numbers = []
# test
numbers = (1..75).to_a.shuffle

until check_continue == 0
  
  

  # 新しいカード作成
  edit_card = cards.map! do |card|
    card.split(/[|]/)
  end

# test
p select_number = numbers.shift(1)
p selected_number = select_number.sample.to_s.rjust(2)
already_numbers << selected_number
puts "いままで出た数字<<<#{already_numbers}"
puts "#{already_numbers.size}回目の挑戦"
puts "~~~~~~~~~~~~~~~~~~~~~~~"


# selected_number = [*1..75].sample.to_s.rjust(2)
#   already_numbers << selected_number
#   puts "#{selected_number}が出ました"
#   puts "いままで出た数字<<<#{already_numbers}"
#   puts "#{already_numbers.size}回目の挑戦"
#   puts "~~~~~~~~~~~~~~~~~~~~~~~"



  # カードチェック
  edit_card.map do |check_line|
    check_line.map! do |number|
      if number == selected_number
        number = "  "
      else
        number
      end
    end
  end
  
  # 縦列チェック
  lines = lines.map do |edit_line|
    edit_line.map! do |number|
      if number == selected_number
        number = nil
        puts "#{selected_number}が当たりました"
      else
        number
      end
    end
  end
  
  
  
  # 横列チェック
  columns = columns.map do |edit_columns|
    edit_columns.map! do |number|
      if number == selected_number
        number = nil
      else
        number
      end
    end
  end
  
  # カード編成
  cards = edit_card.map! do |card|
    card.join("|")
  end
  
  puts cards
  
  
  
  # BINGO 確認

puts "縦確認"

  lines.each do |check_line|
    check_line.compact!
    p check_line.size
  end
  
puts "横確認"

  columns.each do |check_column|
    check_column.compact!
    p check_column.size
  end

  # BINGO 確認メッセージ
  if lines.include?([]) || columns.include?([])
    puts "B I N G O!!!!"
    check_continue = 0
  else
    puts "続けますか？続けるなら 1 を押してください"
    check_continue = gets.chomp.to_i
  end

    
  
end
