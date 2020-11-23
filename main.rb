require "./bingo_system"

# =======ビンゴの定義=================================
BINGO_SIZE = 5
BINGO_BASE_RANGE = 15
# ビンゴ横列の定義
rows = Array.new(BINGO_SIZE) do |index|
  first = 1 + index * BINGO_BASE_RANGE
  last = (1 + index) * BINGO_BASE_RANGE
  (first..last).to_a.shuffle.take(BINGO_SIZE)
end
# 穴を開ける
rows[2][2] = "  "
# ビンゴ縦列の初期定義
columns = rows.transpose
# 抽選番号の定義
numbers = (1..BINGO_SIZE*BINGO_BASE_RANGE).to_a.shuffle
already_numbers = []
selected_number = ""
# リーチチェック用真偽値
bool_value = false
# =================================================


# ======表示用======================================
# スタート表示
start_massage
# ======カードの表示(1回目)==========================
puts display_card = display(build_bingo_card(columns))
# スタート確認
start_confirm
# ======カードの表示(２回目)=========================
check_continue = 1
until check_continue == 0
  # 抽選番号の取り出し
  selected_number = select_numbers(numbers, already_numbers, selected_number)
  # 途中経過報告メッセージ
  interval_messages(selected_number, already_numbers)
  # 「縦列」の抽選番号照合あとの、新しいカード生成前の縦列準備
  checked_card_columns = new_columns(display_card, selected_number, bool_value)
  # 「横列」の抽選番号照合
  checked_card_rows = new_rows(rows, selected_number, bool_value)
  # 新しくカードを生成（２回目以降）
  puts display_card = display(checked_card_columns)
  # ビンゴの判定
  check_continue = bingo_judgement(checked_card_columns, checked_card_rows, already_numbers, check_continue)
end
