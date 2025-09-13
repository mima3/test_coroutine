<?php
declare(strict_types=1);

// Fiber: suspend → resume / throw で呼び出し側と往復するデモ
$fiber = new Fiber(function (string $name) {
    echo "fiber: start for {$name}\n";

    // 1回目の suspend: 呼び出し側に値を返し、ここで一時停止
    $recv1 = Fiber::suspend("s1: from fiber to main");
    echo "fiber: resumed; got '{$recv1}' from main\n";

    try {
        // 2回目の suspend
        $recv2 = Fiber::suspend("s2: from fiber to main");
        echo "fiber: resumed #2; got '{$recv2}' from main\n";
    } catch (RuntimeException $e) {
        // 呼び出し側の ->throw() はここで捕捉される
        echo "fiber: caught RuntimeException: {$e->getMessage()}\n";
        // 例外処理後にもう一度 suspend（throw() の戻り値として呼び出し側へ）
        $ack = Fiber::suspend("s3: after exception");
        echo "fiber: after-exception resume; got '{$ack}'\n";
    }

    // Fiber の最終的な戻り値（呼び出し側は getReturn() で受け取る）
    return "result:{$name}";
});

echo "main: start()\n";
$val1 = $fiber->start("alice");         // → "s1: from fiber to main"
echo "main: start() returned: {$val1}\n";

echo "main: resume('ack1')\n";
$val2 = $fiber->resume("ack1");         // → "s2: from fiber to main"
echo "main: resume() returned: {$val2}\n";

echo "main: throw(RuntimeException('boom'))\n";
$val3 = $fiber->throw(new RuntimeException("boom")); // → "s3: after exception"
echo "main: throw() returned: {$val3}\n";

echo "main: resume('final-ack')\n";
$val4 = $fiber->resume("final-ack");    // ここで fiber は終了（次の suspend なし）
echo "main: final resume() returned: " . var_export($val4, true) . "\n";

echo "main: isStarted=" . ($fiber->isStarted() ? "yes" : "no")
   . " isSuspended=" . ($fiber->isSuspended() ? "yes" : "no")
   . " isTerminated=" . ($fiber->isTerminated() ? "yes" : "no") . "\n";

// 終了後の戻り値
echo "main: fiber return value: " . $fiber->getReturn() . "\n";
