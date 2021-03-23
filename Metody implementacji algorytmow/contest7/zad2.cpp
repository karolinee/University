#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
    
    long long n, q;
    cin >> n >> q;

    long long arr[n + 1];
    long long queries[n+2];
    for(int i = 1; i <= n; i++){
        long long tmp;
        cin >> tmp;
        arr[i] = tmp;
        queries[i] = 0;
    }

    while(q--){
        long long l, r;
        cin >> l >> r;
        queries[l] += 1;
        queries[r + 1] -= 1;
    }

    for(int i = 2; i <= n; i++){
        queries[i] += queries[i-1];
    }

    sort(arr + 1, arr + n + 1);
    sort(queries + 1, queries + n + 1);

    long long result = 0;
    for(int i = 1; i <= n; i++){
        result += (arr[i] * queries[i]);
    }

    cout << result;

	return 0;
}