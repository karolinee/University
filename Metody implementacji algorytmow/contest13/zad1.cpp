#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n, t;

    cin >> n >> t;

    int portals[n];

    for(int i = 1; i < n ; i++ ){
        int p;
        cin >> p;
        portals[i] = p;
    }
    int tmp = 1;
    while(tmp != t && tmp < n){
        tmp += portals[tmp];
    }

    if(tmp == t) cout << "YES";
    else cout << "NO";


	return 0;
}