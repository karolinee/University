#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int T, V, E;

    cin >> T;

    while(T-- > 0){
        cin >> V >> E;
        cout << 2 - V + E << "\n";
    }
    
	return 0;
}