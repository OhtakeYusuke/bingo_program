
# それぞれの列の元を作成
b = (1..15).to_a.shuffle.take(5)
i = (16..30).to_a.shuffle.take(5)
n = (31..45).to_a.shuffle.take(5)
g = (46..60).to_a.shuffle.take(5)
o = (61..75).to_a.shuffle.take(5)

# タイトルを作成
bingo = " B| I| N| G| O"
# linesからrowsに修正
rows = [b, i, n, g, o]
# column 横列を作成
columns = rows.transpose
# 表示するカードでビンゴ中央の穴を作成
columns[2][2] = nil
rows[2][2] = nil

# 縦列が整列するように右に揃える
pre_cards = columns.map do |pre_card|
  pre_card.map do |number|
    number.to_s.rjust(2)
  end
end

# 文字列として連結させてカード表示を作成
cards = pre_cards.map! do |card|
  card.join("|")
end


# 縦と横の中央の穴あけ
# rows = rows.map do |pre_line|
#   pre_line.map do |number|
#     number.to_s.rjust(2)
#   end
# end
# # チェック用の穴あけ
# rows[2][2] = nil

# columns = columns.map do |pre_column|
#   pre_column.map do |number|
#     number.to_s.rjust(2)
#   end
# end
# # チェック用の穴あけ
# columns[2][2] = nil

# 上記をメソッドに修正
def lines_array_to_string(lines)
  lines.map! do |pre_line|
    pre_line.map do |number|
      number.to_s.rjust(2)
    end
  end
  lines[2][2] = nil
  
  return lines
end

lines_array_to_string(rows)
lines_array_to_string(columns)

# 表示画面スタート
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

# スタートメッセージ・タイトル・カード表示
puts start_message
# puts bingo
# puts cards

# 上記をメソッドに修正
def show_card(bingo,card)
  puts bingo
  puts card
end

show_card(bingo, cards)


# スタートの確認
start_button = 0
print " 1 を入力してください>>> "
start_button = gets.chomp.to_i
puts "----------------------------------"

# スタートの再確認
while start_button == 0
  print "入力が違います。 1 を押してください>>> "
  start_button = gets.chomp.to_i
  puts "-----------------------------------"
end

# 繰り返しに入れたくない変数
check_continue = 1
already_numbers = []
numbers = (1..75).to_a.shuffle

# ゲーム開始
until check_continue == 0

  # # 新しいカードの再作成（文字列から配列）
  # edit_card = cards.map! do |card|
  #   card.split(/[|]/)
  # end

  # 上記をメソッドに修正
  def card_string_to_array(cards)
    cards.map! { |card| card.split(/[|]/)}
    return cards
  end

  card_string_to_array(cards)



  # 抽選番号の取り出し
  select_number = numbers.shift(1)
  # 抽選番号を整えてカードに反映しやすくする
  selected_number = select_number.sample.to_s.rjust(2)
  # 抽選番号を既出番号へ追加する
  already_numbers << selected_number


  # ゲーム途中のアナウンス
  interval = <<~TEXT



  ~~~#{already_numbers.size}回目の挑戦~~~
  今回出た数字>>>  #{selected_number}
  いままで出た数字>>>>  #{already_numbers}
  ~~~~~~~~~~~~~~~~~~~~~~~
  TEXT

  puts interval



  # # 抽選番号とカード内の番号の照合と一致した番号の空欄
  # cards.map do |check_line|
  #   check_line.map! do |number|
  #     if number == selected_number
  #       number = "  "
  #       # else文を書かないとうまくできなかったので一応書く
  #     else
  #       number
  #     end
  #   end
  # end

  # 上記の内容をメソッド化
  def check_card_number(cards,select_number)
    cards.map do |check_line|
      check_line.map! do |number|
        if number == select_number
          number = "  "
        else
          number
        end
      end
    end
    return cards
  end

  check_card_number(cards,selected_number)


  # # ビンゴ時の縦列チェック
  # rows = rows.map do |edit_line|
  #   edit_line.map! do |number|
  #     if number == selected_number
  #       number = nil
  #     else
  #       number
  #     end
  #   end
  # end

  # # ビンゴ時の横列チェック
  # columns = columns.map do |edit_columns|
  #   edit_columns.map! do |number|
  #     if number == selected_number
  #       number = nil
  #     else
  #       number
  #     end
  #   end
  # end

  # 上記の内容をメソッド化
  def check_lines_number(lines, select_number)
    lines.map! do |edit_lines|
      edit_lines.map! do |number|
        if number == select_number
          number = nil
        else
          number
        end
      end
    end
    return lines
  end

  check_lines_number(rows,selected_number)
  check_lines_number(columns,selected_number)

  

  # カードの再編成（配列から文字列）
  # cards = edit_card.map! do |card|
  #   card.join("|")
  # end
  
  # 上記の内容をメソッド化
  def cards_array_to_string(edit_card)
    cards = edit_card.map! do |card|
      card.join("|")
    end
    return cards
  end

  cards_array_to_string(cards)

  
  # 照合を終えた後のカードとタイトル表示
  show_card(bingo, cards)
  
  # # 縦列のリーチ確認
  # rows.each do |check_line|
  #   check_line.compact!
  #   if check_line.size == 1
  #     puts "縦列リーチです"
  #     #テスト用
  #   else
  #     puts check_line.size
  #   end
  # end
  
  # # 横列のリーチ確認
  # columns.each do |check_column|
  #   check_column.compact!
  #   if check_column.size == 1
  #     puts "横列リーチです"
  #   end
  # end

  bool_value = false
  def check_reach_lines(lines,bool_value)
    lines.each do |check_line|
      check_line.compact!
      if check_line.size == 1
        bool_value = true
      end
    end
    puts "リーチです"  if bool_value
  end

  check_reach_lines(rows, bool_value)
  check_reach_lines(columns, bool_value)

  ## BINGO したときの確認メッセージとゲームの続行確認メッセージ
  if rows.include?([]) || columns.include?([])
    puts "B I N G O!!!!#{already_numbers.size}回目の挑戦でBINGOでした"
    check_continue = 0
  else
    puts "続けますか？続けるなら 1 を押してください"
    check_continue = gets.chomp.to_i
  end

  # 下記のメソッドでBINGOすると繰り返し処理が止まらなくなるのでコメントアウト

  # def bingo_or_continue(rows, columns, already_numbers)
  #     if rows.include?([]) || columns.include?([])
  #       puts "B I N G O!!!!#{already_numbers.size}回目の挑戦でBINGOでした。終了する時は ０ を押してください"
  #       return check_continue = gets.chomp.to_i
  #     else
  #       puts "続けますか？続けるなら 1 を押してください"
  #       return check_continue = gets.chomp.to_i
  #     end
  # end

  # bingo_or_continue(rows, columns, already_numbers)

end
