#include <bits/stdc++.h>
using namespace std;
long long divisors[1000001];

long long d(long long n){
    if(divisors[n] != 0){
        return divisors[n];
    }
    int res = 0;
    for(int i = 1; i * i <= n; i++){
        if(n % i == 0){
            res++;
            if(i * i != n){
                res++;
            }
        }
    }

    divisors[n] = res;
    return res;
}

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int a,b,c;
    cin >> a >> b >> c;

    long long res = 0;

    for(long long i = 1; i <= a; i++){
        for(long long j = 1; j <= b; j++){
            for(long long k = 1; k <= c; k++){
                res += d(i*j*k);
            }
        }
    }

    cout << res % 1073741824;
	return 0;
}