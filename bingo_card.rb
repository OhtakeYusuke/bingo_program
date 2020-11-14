
b = (1..15).to_a.shuffle.take(5)
i = (16..30).to_a.shuffle.take(5)
n = (31..45).to_a.shuffle.take(5)
g = (46..60).to_a.shuffle.take(5)
o = (61..75).to_a.shuffle.take(5)

bingo = " B| I| N| G| O"

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

start_message = <<~TEXT



======================================

      ~~~~~~~~~~~~~~~~~~~~~~~~
        B I N G O - G A M E
      ~~~~~~~~~~~~~~~~~~~~~~~~
    何回目の挑戦で BINGO できるかな？

それではカードをお配りします！
ゲームを開始するには 1 をおしてください
中断は コントロールキー と C を押してください

======================================
TEXT

puts start_message
puts bingo
puts cards

start_button = 0

print " 1 を入力してください>>> "
start_button = gets.chomp.to_i
puts "----------------------------------"

while start_button == 0
  print "入力が違います。 1 を押してください>>> "
  start_button = gets.chomp.to_i
  puts "-----------------------------------"
end





check_continue = 1
already_numbers = []
numbers = (1..75).to_a.shuffle

until check_continue == 0
  # 新しいカード作成
  edit_card = cards.map! do |card|
    card.split(/[|]/)
  end

  select_number = numbers.shift(1)
  selected_number = select_number.sample.to_s.rjust(2)
  already_numbers << selected_number

  interval = <<~TEXT


  ~~~#{already_numbers.size}回目の挑戦~~~
  今回出た数字>>>  #{selected_number}
  いままで出た数字>>>>  #{already_numbers}
  ~~~~~~~~~~~~~~~~~~~~~~~
  TEXT

  puts interval

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
  
  puts bingo
  puts cards
  
  # BINGO 確認
  lines.each do |check_line|
    check_line.compact!
    if check_line.size == 1
      puts "縦列リーチです"
    end
  end
  
  columns.each do |check_column|
    check_column.compact!
    if check_column.size == 1
      puts "横列リーチです"
    end
  end

  # BINGO 確認メッセージ
  if lines.include?([]) || columns.include?([])
    puts "B I N G O!!!!#{already_numbers.size}回目の挑戦でBINGOでした"
    check_continue = 0
  else
    puts "続けますか？続けるなら 1 を押してください"
    check_continue = gets.chomp.to_i
  end

end
