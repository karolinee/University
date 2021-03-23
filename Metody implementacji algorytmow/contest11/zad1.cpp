#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int y,w;
    cin >> y >> w;
    int max = y;
    if(w > max) max = w;
    
    int prop = 6 - max + 1;
    
    switch(prop){
        case 2:
            cout << "1/3";
            break;
        case 3:
            cout << "1/2";
            break;
        case 4:
            cout << "2/3";
            break;
        case 6: 
            cout << "1/1";
            break;
        default:
            cout << prop << "/6";
            break;
    }

	return 0;
}