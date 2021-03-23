#include <bits/stdc++.h>
using namespace std;

int binary_search(vector <int> arr, int left, int right, int x){
    if( right >= left){
        int mid = left + right / 2;

        if(arr[mid] == x) return x;

        if(arr[mid] > x) return binary_search(arr, left, mid - 1, x);

        return binary_search(arr, mid + 1, right, x);

    }  
    
    return -1;
}

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n, m;
    cin >> n >> m;

    vector <int> a(n);
    vector <int> b(m);

    for(int i = 0; i < n; i++){
        cin >> a[i];
    }

    for(int i = 0; i < m; i++){
        cin >> b[i];
    }

    sort(a.begin(), a.end());

    for(int i = 0; i < m; i++) {
        int result = binary_search(a, 0, n-1, b[i]);
        if (result == -1) cout << 0 << " ";
        else cout << result<< " ";
    }

	return 0;
}