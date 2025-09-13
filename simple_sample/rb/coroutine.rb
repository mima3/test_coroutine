# 2) async/await 風：Fiber＋簡易スケジューラ
def worker(name, delay_ms)
  Fiber.new do
    puts "#{name}: start"
    3.times do |i|
      puts "  #{name}: step #{i + 1}... start"
      Fiber.yield [:sleep, delay_ms / 1000.0]
      puts "  #{name}: step #{i + 1}... end"
    end
    puts "#{name}: done"
    :done
  end
end

def run(*fibers)
  queue = fibers.map { |f| [f, Time.now] }
  until queue.empty?
    queue.sort_by! { |(_, t)| t }
    fib, wake = queue.shift
    now = Time.now
    sleep(wake - now) if wake > now
    result = fib.resume
    if result.is_a?(Array)
      cmd, sec = result
      queue << [fib, Time.now + sec] if cmd == :sleep
    end
  end
  puts "all done"
end

puts "\n== Fiber-based coroutine demo =="
a = worker("A", 150)
b = worker("B", 120)
run(a, b)
