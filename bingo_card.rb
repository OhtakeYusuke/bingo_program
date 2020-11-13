
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

numbers = [*1..75]

selected_number = numbers.shuffle!.take(1)

def check_line_number(lines,selected_number)
  lines.map! do |number|
    if number == selected_number
      number = nil
    end
  end
end

def check_column_number(lines,selected_number)
  columns.map! do |number|
    if number == selected_number
      number = nil
    end
  end
end

def check_cards_number(cards, selected_number)
  cards.map! do |number|
    if number == selected_number
      number = nil
    end
  end
end

check_cards_number(cards, selected_number)
puts cards
