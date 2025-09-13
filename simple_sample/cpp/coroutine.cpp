#include <iostream>
#include <coroutine>
#include <utility>
#include <optional>
#include <vector>
#include <cassert>
#include <version>
#include <generator>


// ===== C++20: 手動で回すコルーチン Task（resume で進めるだけの超最小）=====
struct Task {
  struct promise_type {
    std::suspend_always initial_suspend() noexcept { return {}; } // 生成直後は停止
    std::suspend_always final_suspend()   noexcept { return {}; }
    void return_void() {}
    void unhandled_exception() { std::terminate(); }
    Task get_return_object() { 
      return Task{ std::coroutine_handle<promise_type>::from_promise(*this) };
    }
  };
  using handle = std::coroutine_handle<promise_type>;
  handle h{};
  explicit Task(handle h_) : h(h_) {}
  Task(Task&& o) noexcept : h(std::exchange(o.h, {})) {}
  Task(const Task&) = delete;
  ~Task() { if (h) h.destroy(); }
  bool done() const { return !h || h.done(); }
  void resume() { if (h && !h.done()) h.resume(); }
};

Task demo_task() {
  std::cout << "[task] start\n";
  co_await std::suspend_always{};    // 1 回目の resume でここまで進んで停止
  std::cout << "[task] resumed\n";   // 2 回目の resume でここに来る
}

// ===== C++23: std::generator が使える環境なら同じくフィボナッチ =====
std::generator<int> fib23(int max) {
  int a = 1, b = 1;
  while (b < max) {
    co_yield b;
    auto next = a + b;
    a = b; b = next;
  }
}

int main() {
  // --- 手動コルーチン（resume で進行） ---
  std::cout << "\n== Manual Task (resume) ==\n";
  Task t = demo_task();
  std::cout << "resume #1\n";
  t.resume();
  std::cout << "resume #2\n";
  t.resume();
  std::cout << "task done? " << std::boolalpha << t.done() << "\n";

  // --- std::generator があれば試す ---
  std::cout << "\n== C++23 std::generator ==\n";
  for (int v : fib23(100)) {
    std::cout << "std::generator: " << v << "\n";
  }
}
