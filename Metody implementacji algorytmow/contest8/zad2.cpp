#include <bits/stdc++.h>
using namespace std;



int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n;
    cin >> n;
    double p;
    cin >> p;
    int t;
    cin >> t;

    double dp[t+1][n+1] ={};

    dp[0][0] = 1.0;

    for(int i = 0; i < t ; i++){
        for(int j = 0; j <= n; j++){
            if(j == n){
                dp[i+1][j]+= dp[i][j];
            }
            else{
                dp[i+1][j+1] += dp[i][j] * p;
                dp[i+1][j] += dp[i][j] * (1.0-p); 
            }      
        }
    }

    for(int i = 0; i <= t ; i++){
        for(int j = 0; j <= n; j++){
            cout << dp[i][j] << " ";
        }
        cout << endl;
    }

    double res = 0.0;
    for(int i = 0; i <= n; i++){
        res += (dp[t][i] * i);
    }
    cout << setprecision(9) << res << "\n";

    
	return 0;
}