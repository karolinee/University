#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    long long n, d;
    cin >> n >> d;
    
    long long arr[n] = {};
    for(int i = 0; i < n; i++){
        cin >> arr[i];
    }

    long long res = 0;

    for(int l = 0; l < n - 2; l++){
        long long r = upper_bound(arr, arr+n, arr[l] + d) - arr - 1;
        res += ((r-l)*(r-l-1)/2);
    }


    cout << res;
	return 0;
}