require './bingo_card'

# タイトルを作成
bingo = " B| I| N| G| O"

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


check_continue = 1

until check_continue == 0

    card_string_to_array(cards)
