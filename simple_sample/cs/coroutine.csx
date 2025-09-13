using System;
using System.Threading.Tasks;

Task Sleep(int ms) => Task.Delay(ms);

async Task Worker(string name, int delayMs)
{
    Console.WriteLine($"{name}: start");
    for (int i = 1; i <= 3; i++)
    {
        Console.WriteLine($"  {name}: step {i}... start");
        await Sleep(delayMs);
        Console.WriteLine($"  {name}: step {i}... end");
    }
    Console.WriteLine($"{name}: done");
}

var a = Worker("A", 150);
var b = Worker("B", 120);
await Task.WhenAll(a, b);
Console.WriteLine("all done");
