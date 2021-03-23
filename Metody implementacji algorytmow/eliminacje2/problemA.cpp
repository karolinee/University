#include <bits/stdc++.h>
using namespace std;


int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n, x;

    cin >> n >> x;
    int items = 0;

    int max = 0;
    int tab[n] = {};
    for(int i = 0; i < n; i++){
        cin >> tab[i]; 
    }
    sort(tab, tab + n);

    for(int i = 0; i < n; i++){
        int tmp = tab[i];
        if(tmp + max <= x){
            items++;
            if(tmp > max){
                int t = tmp;
                tmp = max;
                max = t;
            }
        }
    }
    
    if(items == 0) items = 1;


    cout << items;
    
    
    

    return 0;
}