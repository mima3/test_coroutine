def generator(max):
    print('  start generator function')
    a = 1
    b = 1
    while max > b:
        print("    start yield", b)
        yield b  # ここで中断する
        print("    end yield", b)
        a = b
        b = a + b
    print('exit loop')

print('for loop.')
g = generator(30)
for n in g:
    print("value:", n)

print('next.')
g = generator(30)
try:
    while True:
        print(next(g))
except StopIteration:
    # ジェネレータの生成が尽きた
    pass
finally:
    g.close() 
