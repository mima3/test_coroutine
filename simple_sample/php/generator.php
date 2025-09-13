<?php
declare(strict_types=1);

// 基本のジェネレータ
function simple(): Generator {
    echo "  start...simple generator\n";
    echo "  start...yield 1\n";
    yield 1;
    echo "  start...yield 2\n";
    yield 2;
    echo "  start...yield 3\n";
    yield 3;
    echo "  end...simple generator\n";
}

echo "== simple generator ==\n";
foreach (simple() as $v) {
    echo "main: got {$v}\n";
}

// send/throw 付きのインタラクティブなジェネレータ
function interactive(): Generator {
    echo "gen: start\n";
    $x = yield "hello";                // 呼び出し側の send() が戻り値になる
    echo "gen: received via send(): {$x}\n";

    try {
        $y = yield "world";            // ここで throw() を受けられる
        echo "gen: received #2 via send(): {$y}\n";
    } catch (RuntimeException $e) {
        echo "gen: caught exception: {$e->getMessage()}\n";
        $z = yield "after-exception";  // throw() の戻り値として呼び出し側へ
        echo "gen: received after-exception ack: {$z}\n";
    }

    return "bye";                      // getReturn() で受け取れる
}

echo "\n== interactive generator (send/throw) ==\n";
$g = interactive();

echo "main: current = " . $g->current() . "\n"; // "hello"

echo "main: send('ACK1')\n";
$next = $g->send("ACK1");             // 次の yield 値 "world" が返る
echo "main: got next = {$next}\n";

echo "main: throw(RuntimeException('boom'))\n";
$next2 = $g->throw(new RuntimeException("boom")); // "after-exception"
echo "main: got next = {$next2}\n";

echo "main: send('ACK3')\n";
$end = $g->send("ACK3");              // ここで generator は終了、戻り値取得へ
echo "main: send() returned: " . var_export($end, true) . "\n";

echo "main: valid? " . ($g->valid() ? "yes" : "no") . "\n";
echo "main: return value: " . $g->getReturn() . "\n";
