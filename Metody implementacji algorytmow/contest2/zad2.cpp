#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
	
	int n;
    cin >> n;

    bool appear[n+1]={0};
    int result = 0;

    int temp;
    for(int i= 0; i< n; i++){
        cin >> temp;
        if(temp > n || appear[temp]){
            result++;
        }
        else{
            appear[temp] = true;
        }
        

    }

    cout << result;

	return 0;
}

