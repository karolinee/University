function prime(n) {
    if (n < 2) return false;
    if (n % 2 == 0) return (n == 2);
    for(let i = 3; i * i <= n; i+=2){
        if(n % i == 0) return false;
    }
    return true;
}

let primes = []
for(let i = 2; i <= 100000; i++) {
    if(prime(i)) primes.push(i);
}

console.log(primes)