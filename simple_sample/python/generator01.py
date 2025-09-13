def generator(max):
    a = 1
    b = 1
    while max > b:
        print("    start yield", b)
        yield b
        print("    end yield", b)
        a = b
        b = a + b
    print('exit loop')

g = generator(100)
for n in g:
    print("iterator:", n)
