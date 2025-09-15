import asyncio
import time


@asyncio.coroutine
def test(name, n):
    print("start...", name)
    yield from asyncio.sleep(n)
    print("end...", name)
    return "{}:{}".format(name, n)


@asyncio.coroutine
def main():
    start_time = time.perf_counter()
    result = yield from asyncio.gather(
        test("1番目", 1.0),
        test("2番目", 2.0),
        test("3番目", 3.0),
    )
    print(result)
    print("done in {:.3f}s".format(time.perf_counter() - start_time))


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    try:
        loop.run_until_complete(main())
    finally:
        loop.close()