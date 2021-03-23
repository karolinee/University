#include <bits/stdc++.h>
using namespace std;

int MOD = 1000000007;

long long fastPower(long long x, long long n){
    //cout << x <<" " << n << endl;
    long long res = 1;
    while(n > 0){
        if(n % 2){
            res *= x;
            res %= MOD;
            n--;
        }
        x *=x;
        x %= MOD;
        n /=2;
    }

    return res;
}
int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    long long n,x;
    cin >> n >> x;

    long long arr[n] = {};
    long long sum = 0;
    for(int i = 0; i < n ;i++){
        cin >> arr[i];
        sum += arr[i];
    }
    
    map<long long, long long> exp;
    for(int i = 0; i < n ;i++){
        exp[sum - arr[i]]++;
    }

    for(auto i = exp.begin(); i != exp.end(); i++){
        if(i->second >= x){
            long long div = i->second / x;
            exp[i->first + 1] += div;
            exp[i->first] -= div * x;
        }
    }

    auto it = exp.begin();
    while(it->second == 0){
        it++;
    }

    cout << fastPower(x, min(it->first, sum));

	return 0;
}