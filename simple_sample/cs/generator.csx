IEnumerable<int> Fib(int max) {
    int a = 0, b = 1;
    while (b < max) {
        Console.WriteLine($"yield {b} (before)");
        yield return b;                         // ← ここで一旦呼び出し元へ戻る
        Console.WriteLine($"yield {b} (after)");
        (a, b) = (b, a + b);
    }
    Console.WriteLine("end");
}

foreach (var x in Fib(20)) {
    Console.WriteLine($"got {x}");
}