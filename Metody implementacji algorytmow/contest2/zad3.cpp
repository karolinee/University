#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
	
	int n;
    cin >> n;

    for(int i= 0; i< n; i++){
        int m;
        cin >> m;
        bool used[m*2]={0};
        int a[m*2];
        bool possible = true;
        for(int j = 0; j < m; j++){           
            int temp;
            cin >> temp;
            a[2*j] = temp;
            used[temp-1] = true;
        }
        for(int j = 1; j < 2*m; j+=2){           
            int temp = a[j-1]-1;
            while(used[temp] && temp < 2*m){
                temp++;
            }
            if(temp < 2*m){
                a[j] = temp + 1;
                used[temp]  =true;
            }
            else{
                possible = false;
                break;
            }
        }
        if(possible){
            for(int j = 0; j < 2*m; j++){
                cout << a[j] << " ";
            }
            cout << "\n";
        }
        else{
            cout <<"-1\n";
        }
        

    }

	return 0;
}

