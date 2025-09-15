def generator_inner1():
    print('  start generator_inner1 function')
    yield 1
    yield 2
    yield 3

def generator_inner2():
    print('  start generator_inner2 function')
    yield 11
    yield 12
    yield 13

def generator_outer():
    print('start generator_outer function')
    yield from generator_inner1()
    yield from generator_inner2()

for v in generator_outer():
    print("....", v)