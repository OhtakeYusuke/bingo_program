

numbers = [*1..75]

selected_number = numbers.shuffle!.take(1)

def check_line_number(lines,selected_number)
  lines.map! do |number|
    if number == selected_number
      puts "#{number}が当たりました"
      number = nil
    end
  end
end

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
