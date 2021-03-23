#include <bits/stdc++.h>
using namespace std;


int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n;
    cin >> n;
    
    int slices[n] = {};

    for (int i = 0; i < n; i++){
        cin >> slices[i];
    }

    int sum[n] = {};
    sum[n-1] = slices[n-1];

    int dp[n] = {};
    dp[n-1] = slices[n-1];
    for (int i = n-2; i >= 0; i--){
        sum[i] = sum[i+1] + slices[i];   
        dp[i] = max(dp[i+1], sum[i] - dp[i+1]);
    }

    cout<< sum[0] - dp[0] << " " << dp[0] ;
    
	return 0;
}