#include <bits/stdc++.h>
using namespace std;


int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    vector <int> triangular;

    int n;
    cin >> n;

    for(int i = 1; i * i <= 2*n; i++){
        triangular.push_back((i * (i+1))/2);
    }

    for(auto val : triangular) {
        if( binary_search(triangular.begin(), triangular.end(), n - val)){
            cout << "YES";
            return 0;
        }

    }
    cout << "NO";

	return 0;
}