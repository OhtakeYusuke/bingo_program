require "./bingo_card"

# ユーザ提示用のビンゴカード(columnsを基準にする)
def display(lines)
  display_card = lines.map! do |line|
    line.join("|")
  end
  puts " B| I| N| G| O"
  return  display_card
end

# カードの取り出し
def select_numbers(numbers, already_numbers, selected_number)
  # 抽選番号の取り出し
  select_number = numbers.shift(1)
  # 抽選番号を整えてカードに反映しやすくする
  selected_number = select_number.sample.to_s.rjust(2)
  # 抽選番号を既出番号へ追加する
  already_numbers << selected_number
  selected_number
end

# 「縦列」の抽選番号照合あとの、新しいカード生成前の縦列準備
def new_columns(display_card, selected_number, bool_value)
  # 新しいcolumns生成（番号照合前）
  pre_check_columns = new_create_line(display_card)
  # 各columns列の番号照合(表示用)
  checked_numbers(pre_check_columns, selected_number)
  # リーチ表示準備用
  checked_card_columns = checked_lines(pre_check_columns, selected_number)
  check_reach_line(checked_card_columns, bool_value)
  return checked_card_columns
end

# 「横列」の抽選番号照合
def new_rows(rows, selected_number, bool_value)
  # 各rows列の番号照合準備
  pre_rows_check = build_bingo_card(rows)
  checked_card_rows = checked_lines(pre_rows_check, selected_number)
  # リーチの判定
  check_reach_line(checked_card_rows, bool_value)
  return checked_card_rows
end

# ビンゴの判定
def bingo_judgement(checked_card_columns, checked_card_rows, already_numbers, check_continue)
  # ビンゴ判定と続行確認
  if checked_card_columns.include?([]) || checked_card_rows.include?([])
    puts "B I N G O!!!!#{already_numbers.size}回目の挑戦でBINGOでした"
    check_continue = 0
  else
    puts "続けますか？続けるなら 1 を押してください"
    check_continue = gets.chomp.to_i
  end
end

# ~~~~~~~~~~ゲームメッセージ~~~~~~~
def start_massage
  puts start_message = <<~TEXT
  
  
  
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
end

# 開始確認用ボタン設置
start_button = 0
# スタートの確認
def start_confirm
  print " 1 を入力してください>>> "
  start_button = gets.chomp.to_i
  puts "----------------------------------"
  return start_button
end

# 途中経過メッセージ
def interval_messages(selected_number, already_numbers)
  puts interval_message = <<~TEXT
  
  
  ~~~#{already_numbers.size}回目の挑戦~~~
  今回出た数字>>>  #{selected_number}
  いままで出た数字>>>>  #{already_numbers}
  ~~~~~~~~~~~~~~~~~~~~~~~
  TEXT
end
