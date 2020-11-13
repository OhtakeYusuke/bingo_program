b = (1..15).to_a.shuffle.take(5)
i = (16..30).to_a.shuffle.take(5)
n = (31..45).to_a.shuffle.take(5)
g = (46..60).to_a.shuffle.take(5)
o = (61..75).to_a.shuffle.take(5)

columns = [b, i, n, g, o].transpose
columns[2][2] = nil

columns.map! do |column|
  column.map! do |number|
    number.to_s.rjust(2)
  end
end

lines = columns.map! do |line|
  line.join("|")
end

puts lines
