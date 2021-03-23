#include <bits/stdc++.h>
using namespace std;


int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    long long n, m, h;
    cin >> n >> m >> h;

    long long sum = 0;
    long long sh = 0;
    for(int i = 1; i <= m; i++){
        int tmp;
        cin >> tmp;
        if(i == h) sh = tmp;
        sum += tmp;
    }
    if(sum < n) cout << -1 << "\n";
    else{
        long long sumh = sum - sh;
        double res = 1;
        for(int p = 2; p <= n; p++){
            res = res * (sumh - (n-p))/(sum - (n-p+1));
        }

    cout << setprecision(9) << 1-res << "\n";
    }

    


	return 0;
}