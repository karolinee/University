#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int m, n;
    cin >> m >> n;

    double res = 0;
    for(int i = 1; i <= m; i++){
        double tmp = pow(((double)i/m), n) - pow((double)(i-1)/m,n);
        res = res + (i * tmp);
    }
    cout << setprecision(9) << res << "\n";
	return 0;
}