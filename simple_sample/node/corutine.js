// Node 14+ / ブラウザOK
const sleep = ms => new Promise(r => setTimeout(r, ms));

async function worker(name, delayMs) {
  console.log(`${name}: start`);
  for (let i = 1; i <= 3; i++) {
    console.log(`${name}: step ${i}... start`);
    await sleep(delayMs);        // ← ここで一旦 呼び出し側（イベントループ）へ戻る
    console.log(`${name}: step ${i}... end`);
  }
  console.log(`${name}: done`);
}

(async () => {
  // ここで「待たずに」2つを起動 → 並行して進む
  const a = worker("A", 150);
  const b = worker("B", 120);

  // 両方の完了を待つ
  await Promise.all([a, b]);
  console.log("all done");
})();