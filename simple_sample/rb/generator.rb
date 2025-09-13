# 1) Generator 相当：Enumerator
def generator(max)
  Enumerator.new do |y|
    puts "  start generator...."
    a = 1
    b = 1
    while b < max
      puts "   start yield #{b}"
      cmd = y.yield(b)
      puts "   end   yield #{b} #{cmd}"

      case cmd
      when "Stop"
        # JS の g.return('ok') っぽく：ここで終了値 "ok"
        puts "   stop by outer"
        raise StopIteration, "Stopped"
      end
      a, b = b, a + b
    end
    puts "  end loop...."
    # 自然終了時に終了値を付けたいなら（任意）
  end
end

puts "== Generator demo =="
puts '開始'
g = generator(100)
puts "generator: #{g.inspect}"
g.each { |i| puts "呼び出し元： #{i} #{g.inspect}" }

# Rubyでも呼び出し元からジェネレータに値を設定できる
puts '------------------'
g2 = generator(100)
next1 = g2.next
puts "next -> #{next1} (#{g2.inspect})"
puts "feed...."
g2.feed "Stop"
begin
  g2.next              # ここで :stop が反映されて終了
rescue StopIteration => e
  p e
end
