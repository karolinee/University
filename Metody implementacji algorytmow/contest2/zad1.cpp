#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
	
	int n;
	cin >> n;

    int min;
    int sum = 0;

    int a, p;

    cin >> a >> p;

    sum+= a*p;
    min = p;

    for(int i = 1; i < n; i++){
        cin >> a >> p;
        if ( p < min ){
            sum += a*p;
            min = p;
        }
        else{
            sum+=a*min;
        }      
    }

    cout << sum;

	return 0;
}

