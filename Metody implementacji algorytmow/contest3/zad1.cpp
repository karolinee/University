#include <bits/stdc++.h>
using namespace std;

bool distinct (int x){
    int numbers[10] = {};

    while(x > 0){
        if(numbers[x%10]){
            return false;
        }
        else{
            numbers[x%10] = true;
            x = x/10;
        }
    }

    return true;
}

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
	
	int n;
    cin >> n;;

    bool found = false;
    int newYear = n+1;
    while(!found){
        if(distinct(newYear)){
            break;
        }
        newYear++;
    }

    cout << newYear;

	return 0;
}
