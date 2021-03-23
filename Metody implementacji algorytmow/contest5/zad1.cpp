#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n, k;

    cin >> n >> k;

    int fence[n] = {};

    for(int i = 0; i < n; i++){
        cin >> fence[i];
    }

    int result[n] = {};

    for(int i = 0; i < k; i++) {
        result[0] += fence[i];
    }
    int min = result[0];
    int idx_min = 0;

    for(int i = 1; i <= n - k; i++){
        result[i] = result[i-1] - fence[i-1] + fence[i+k-1];

        if(result[i] < min){
            min = result[i];
            idx_min = i;
        }
    }

    cout << idx_min + 1;
   

	return 0;
}