# symmetric_transfer.rb
# Ruby 3.x でそのまま実行可（docker-compose の ruby:3.3-alpine でもOK）

main = Fiber.current  # ルート（メイン）Fiber

# B：Aから値を受け取り、値を1増やしてAへ返す。一定回数でメインへ戻って終了。
b = Fiber.new do |msg|
  a_fiber, n = msg  # 最初は [相手Fiber, 値] で呼ばれる

  loop do
    puts "  [B] got #{n}"
    n += 1
    if n > 10
      puts "  [B] limit reached -> transfer to main"
      main.transfer(:b_done)     # ★ 呼び出し元（A）には戻さず、明示的にメインへ
    else
      # 相手（A）へ “直接” 制御とデータを渡す（対称）
      msg = a_fiber.transfer([Fiber.current, n])
      a_fiber, n = msg
    end
  end
end

# A：1 から始めて B に渡し、B から戻ってきた次の値で続行
a = Fiber.new do |b_fiber|
  me = Fiber.current
  n  = 1

  loop do
    puts "[A] send #{n} -> B"
    # B へ “直接” 制御移譲。戻りは B が transfer してきたときだけ。
    b_fiber, n = b_fiber.transfer([me, n])
    puts "[A] got from [B] #{n}"
  end
end

puts "== symmetric coroutine (Fiber#transfer) demo =="
# キックオフ：A を開始し、最初の引数として B を渡す
result = a.transfer(b)

puts "main got: #{result.inspect}"
# => :b_done が出力され、A は最後に B に渡した位置で停止したまま（対称コルーチンでは
#    「自動では」戻ってこないのが肝）。必要ならここで a.transfer(...) して続きを実行できます。
