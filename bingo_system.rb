# ビンゴの定義
BINGO_SIZE = 5
BINGO_BASE_RANGE = 15
# ビンゴ横列の定義
rows = Array.new(BINGO_SIZE) do |index|
  first = 1 + index * BINGO_BASE_RANGE
  last = (1 + index) * BINGO_BASE_RANGE
  (first..last).to_a.shuffle.take(BINGO_SIZE)
end
# 抽選番号の定義
numbers = (1..BINGO_SIZE*BINGO_BASE_RANGE).to_a.shuffle
already_numbers = []
selected_number = ""
# 穴を開ける
rows[2][2] = "  "
# ビンゴ縦列の初期定義
columns = rows.transpose
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
# ユーザ提示用のビンゴカード(columnsを基準にする)
def display(lines)
  display_card = lines.map! do |line|
    line.join("|")
  end
  puts " B| I| N| G| O"
  return  display_card
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

# リーチチェック用真偽値
bool_value = false
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

# 開始確認用ボタン設置
start_button = 0
# スタートの確認
def start_confirm
  print " 1 を入力してください>>> "
  start_button = gets.chomp.to_i
  puts "----------------------------------"
  return start_button
end

# ~~~~~~~~~~ゲームメッセージ~~~~~~~
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

# ~~~~~~~~~~~途中経過メッセージ~~~~~~~
def interval_messages(selected_number, already_numbers)
  interval_message = <<~TEXT
  
  
  ~~~#{already_numbers.size}回目の挑戦~~~
  今回出た数字>>>  #{selected_number}
  いままで出た数字>>>>  #{already_numbers}
  ~~~~~~~~~~~~~~~~~~~~~~~
  TEXT
end


# ~~~~~~~~~~表示用~~~~~~~~~~~
# スタート表示
puts start_message
# ======カードの表示(1回目)=======
puts display_card = display(build_bingo_card(columns))
# スタート確認
start_confirm()
check_continue = 1
# ======カードの表示(２回目)======
until check_continue == 0
  # 抽選番号の取り出し
  select_number = numbers.shift(1)
  # 抽選番号を整えてカードに反映しやすくする
  selected_number = select_number.sample.to_s.rjust(2)
  # 抽選番号を既出番号へ追加する
  already_numbers << selected_number
  # 途中経過報告メッセージ
  puts interval_messages(selected_number, already_numbers)
  # 新しいcolumns生成（番号照合前）
  pre_check_columns = new_create_line(display_card)
  # 各columns列の番号照合(表示用)
  checked_card_columns = checked_numbers(pre_check_columns, selected_number)
  # 各rows列の番号照合準備
  pre_rows_check = build_bingo_card(rows)
  # リーチ表示準備用
  checked_card_columns = checked_lines(pre_check_columns, selected_number)
  checked_card_rows = checked_lines(pre_rows_check, selected_number)
  # リーチの判定
    check_reach_line(checked_card_columns, bool_value)
    check_reach_line(checked_card_rows, bool_value)
  # 新しくカードを生成（２回目以降）
  puts display_card = display(checked_card_columns)
  # ビンゴ判定と続行確認
  if checked_card_columns.include?([]) || checked_card_rows.include?([])
    puts "B I N G O!!!!#{already_numbers.size}回目の挑戦でBINGOでした"
    check_continue = 0
  else
    puts "続けますか？続けるなら 1 を押してください"
    check_continue = gets.chomp.to_i
  end
end
