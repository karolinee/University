#include <bits/stdc++.h>
using namespace std;


int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n;
    cin >> n;
    int min = 2000000000;

    for(int i = 1; i * i <= n; i++){
        for(int j = 1; j * j <= n; j++){
            if(n % (i*j) == 0){
                int k = n / (i*j);
                int tmp = 2*(i*j + i*k + j*k);
                if(tmp < min) min = tmp;
            }
        }
    }

    cout << min;

    return 0;
}