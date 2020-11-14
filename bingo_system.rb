

already_numbers = []

p select_number = numbers.shift(1)
p selected_number = select_number.sample.to_s.rjust(2)
already_numbers << selected_number
puts "いままで出た数字<<<#{already_numbers}"
puts "#{already_numbers.size}回目の挑戦"
puts "~~~~~~~~~~~~~~~~~~~~~~~"
