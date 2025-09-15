import asyncio
import time


async def test(name: str, n: float):
    print("start...", name)
    await asyncio.sleep(n)
    print("end...", name)
    return f"{name}:{n}"


async def main():
    start_time = time.perf_counter()
    result = await asyncio.gather(
        test("1番目", 1.0),
        test("2番目", 2.0),
        test("3番目", 3.0),
    )
    print(result)
    print(f"done in {time.perf_counter() - start_time:.3f}s")


if __name__ == "__main__":
    asyncio.run(main())
