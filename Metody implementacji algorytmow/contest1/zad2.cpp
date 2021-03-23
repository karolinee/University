#include <bits/stdc++.h>
using namespace std;

int INF = 1000000000;

int main(){
	int n, m;
    cin >> n >> m;

    char arr[n][m];

    for(int i = 0; i < n; i++){
        cin >> arr[i];
    }

    int walls = 0;


    int rows[n] = {};
    int columns[m] = {};



    for(int i = 0; i < n; i++){
        for(int j = 0; j < m; j++){
            if(arr[i][j] == '*'){
                rows[i]++;
                columns[j]++;
                walls++;
            }
        }
    }


    for(int i = 0; i < n; i++){
        for(int j = 0; j < m; j++){
            int sum = rows[i] + columns[j];
            if(arr[i][j] == '*'){
                sum--;
            }
            if(sum == walls){
                cout << "YES\n";
                cout << i + 1 << " " << j + 1; 
                return 0;
            }
        }
    }
    cout << "NO";

	return 0;
}


