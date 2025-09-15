class CustomError(Exception):
    """A custom domain-specific error."""


def generator(v):
    print('  start generator function')
    try:
        while True:
            print("    start yield", v)
            res = yield v  # ここで中断する
            if res:
                v = res
            print("    end yield", v)
            v = v * 2
    except CustomError as e:
        print('    custom except:', e)

g = generator(3)
try:
    print("1回目のnextの開始")
    v = next(g)
    print("1回目のnextの結果", v)
    print("2回目のnext開始")
    v = next(g)
    print("2回目のnextの結果", v)
    print("generatorに100を与えた")
    v = g.send(100)
    print("generatorに100を与えた結果", v)
    print("send後のnext開始")
    v = next(g)
    print("send後のnext結果", v)
    print("例外送出", v)
    g.throw(CustomError('カスタム例外'))
except StopIteration:
    # ジェネレータの生成が尽きた
    pass
finally:
    g.close() 
