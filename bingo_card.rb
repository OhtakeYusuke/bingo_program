
b = (1..15).to_a.shuffle.take(5)
i = (16..30).to_a.shuffle.take(5)
n = (31..45).to_a.shuffle.take(5)
g = (46..60).to_a.shuffle.take(5)
o = (61..75).to_a.shuffle.take(5)

lines = [b, i, n, g, o]
columns = lines.transpose
columns[2][2] = nil

pre_cards = columns.map do |pre_card|
  pre_card.map do |number|
    number.to_s.rjust(2)
  end
end

cards = pre_cards.map! do |card|
  card.join("|")
end

puts cards
puts "~~~~~~~~~~~~~~~~~"


check_continue = 1
already_numbers = []


until check_continue == 0
  

  # 新しいカード作成
  edit_card = cards.map! do |card|
    card.split(/[|]/)
  end


  selected_number = rand(1..75).to_s.rjust(2)
  already_numbers << selected_number
  puts "#{selected_number}が出ました"
  puts "いままで出た数字<<<#{already_numbers}"
  puts "#{already_numbers.size}回目の挑戦"
  puts "~~~~~~~~~~~~~~~~~~~~~~~"
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
  # lines.map do |edit_line|
  #   edit_line.map! do |number|
  #     if number == selected_number
  #       number = "  "
  #     else
  #       number
  #     end
  #   end
  # end
  
  # 横列チェック
  # columns.map do |edit_columns|
  #   edit_columns.map! do |number|
  #     if number == selected_number
  #       number = "  "
  #     else
  #       number
  #     end
  #   end
  # end
  
  # カード編成
  cards = edit_card.map! do |card|
    card.join("|")
  end
  
  puts cards
  
  
  
  # BINGO 確認
  
  # finish_confirm_lines = false
  # finish_confirm_columns = false
  
  
  # lines.map! do |check_line|
  #   check_line.compact!
  #   if check_line.empty?
  #     puts finish_confirm_lines = check_line.empty?
  #   end
  # end
  
  # columns.map! do |check_column|
  #   check_column.compact!
  #   if check_column.empty?
  #     puts finish_confirm_columns = check_column.empty?
  #   end
  # end
  
  
  
  # if finish_confirm_lines || finish_confirm_columns
  #   puts "B I N G O !!!!!"
  # else
  #   puts "続けますか？続けるなら 1 を押してください"
  #   check_continue = gets.chomp.to_i
  # end
  
    puts "続けますか？続けるなら 1 を押してください"
    check_continue = gets.chomp.to_i
  
end
