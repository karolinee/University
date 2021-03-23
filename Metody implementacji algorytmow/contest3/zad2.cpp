#include <bits/stdc++.h>
using namespace std;

int MAX  = 1000002;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
	
	int n;
    cin >> n;;

    int str[MAX][2] = {};

    for(int i = 2; i <= 2*n; i++){
        for(int j = 1; j < i; j++){
            int temp;
            cin >> temp;
            str[temp][0] = i;
            str[temp][1] = j;
        }
    }

    bool used[2 * n + 1] = {};
    int teams[2 * n + 1];

    for(int i = MAX - 1; i > 0 ; i--){
        int c1 = str[i][0];
        int c2 = str[i][1]; 
        if(!used[c1] && !used[c2]){
            used[c1] = true;
            used[c2] = true;
            teams[c1] = c2;
            teams[c2] = c1;
        }
    }

    for(int i = 1; i <= 2*n ; i++){
        cout << teams[i] << " ";
    }

	return 0;
}
