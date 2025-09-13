// https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Generator

function *generator(max) {
  console.log('  start generator....')
  let a = 1;
  let b = 1;
  try {
    while (max > b) {
      console.log("   start yield", b);
      yield b;
      console.log("   end yield", b);
      a = b;
      b = a + b;
    }
  } catch (ex) {
    console.error(ex)
    return "xxxx";
  }
}

console.log('開始');
const g = generator(100);
console.log("generator:", g);
for (const i of g) {
  console.log("呼び出し元：", i, g)
}

console.log('------------------')
const g2 = generator(100);
console.log(g2.next(), g2);
console.log(g2.return('ok'));

console.log('------------------')
const g3 = generator(100);
console.log(g3.next(), g2);
console.log(g3.throw('error'));
