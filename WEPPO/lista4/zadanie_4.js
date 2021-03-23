console.log('Podaj swoje imie')
process.stdin.once('data', (chunk) => {
    console.log('Witaj ' + chunk.toString().trim());
    process.exit();
})