# stackful_fiber_nested.rb
def leaf(n)
  puts "    leaf(#{n}) before yield"
  Fiber.yield n                # ← 深いフレームから一発でサスペンド
  puts "    leaf(#{n}) after yield"
end

def mid2(n)
  puts "  mid2 -> leaf"
  leaf(n)                      # ← mid2 は “配管” 不要（普通のメソッド）
  puts "  mid2 after leaf"
end

def mid1(n)
  puts " mid1 -> mid2"
  mid2(n)                      # ← ここも配管不要
  puts " mid1 after mid2"
end

f = Fiber.new do
  puts "fiber: start"
  2.times { |i| mid1(i) }      # 0 と 1 で2回、leaf の中で yield
  puts "fiber: done"
  :done
end

puts "== stackful Fiber demo =="
p f.resume     # => 0   （leaf(0) の yield で停止）
puts "-- resume --"
p f.resume     # => 1   （leaf(0) の続き→mid2/ mid1 を経て次の leaf(1) で停止）
puts "-- resume --"
p f.resume     # => :done （leaf(1) の続き→終了）
