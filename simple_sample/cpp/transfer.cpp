// g++ -std=c++23 transfer.cpp -o transfer
#include <coroutine>
#include <iostream>

// 「この await は target を直ちに再開して“対称移譲”する」awaitable
struct TransferTo {
  std::coroutine_handle<> target;
  bool await_ready() const noexcept { return false; }
  std::coroutine_handle<> await_suspend(std::coroutine_handle<>) const noexcept {
    // done() なハンドルを誤って再開しないようにガード
    return (target && !target.done()) ? target : std::noop_coroutine();
  }
  void await_resume() const noexcept {}
};

struct Task {
  struct promise_type {
    Task get_return_object() { return Task{std::coroutine_handle<promise_type>::from_promise(*this)}; }
    std::suspend_always initial_suspend() noexcept { return {}; }
    std::suspend_always final_suspend()   noexcept { return {}; }
    void return_void() noexcept {}
    void unhandled_exception() { std::terminate(); }
  };
  std::coroutine_handle<promise_type> h;
  void start()            { h.resume(); }
  bool done() const       { return !h || h.done(); }
};

std::coroutine_handle<> g_ping, g_pong;

Task ping() {
  for (int i = 1; i <= 3; ++i) {
    std::cout << "ping " << i << "\n";
    co_await TransferTo{g_pong};      // ← ここで“Yへ transfer”
  }
  std::cout << "ping done\n";
}

Task pong() {
  for (int i = 1; i <= 3; ++i) {
    std::cout << "pong " << i << "\n";
    co_await TransferTo{g_ping};      // ← 相手へ transfer
  }
  std::cout << "pong done\n";
}

int main() {
  Task P = ping(); g_ping = P.h;
  Task Q = pong(); g_pong = Q.h;

  P.start();                   // 始動。以後は transfer の連鎖で相手が直ちに走る
  if (!Q.done()) Q.h.resume(); // どちらかが先に終わったら残りを drain
  if (!P.done()) P.h.resume();
}
