def generator_inner1():
    print('  start generator_inner1 function')
    yield 1
    yield 2
    yield 3
    return 4

def generator_inner2():
    print('  start generator_inner2 function')
    yield 11
    yield 12
    yield 13
    return 14

def generator_outer():
    print('start generator_outer function')
    sub1 = yield from generator_inner1()
    print('  sub generator1 return', sub1)
    sub2 = yield from generator_inner2()
    print('  sub generator2 return', sub2)

for v in generator_outer():
    print("....", v)
