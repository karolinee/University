#include <bits/stdc++.h>
using namespace std;

int INF = 1000000000;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
	
	int n;
	cin >> n;
    
    string directions;
    int positions[n];

    cin >> directions;

    for(int i = 0; i < n; i++){
        cin >> positions[i];
    }

    int min = INF;
    for(int i = 0; i < n - 1; i++){
        if(directions[i] == 'R' && directions[i+1] == 'L'){
            int temp = (positions[i+1] - positions[i]) / 2;
            if (temp  < min){
                min = temp;
            } 
        }
    }
    
    if (min == INF) {
        cout << -1;
    }
    else{
        cout << min;
    }

	return 0;
}


