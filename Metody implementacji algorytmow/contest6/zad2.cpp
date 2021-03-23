#include <bits/stdc++.h>
using namespace std;

string input;

int count(char c, int left, int right){
    int res = 0;
    for(int i = left; i < right; i++){
        if(input[i] != c) res++;
    }
    return res;
}
int answ(char c, int left, int right){
    if(right - left == 1){
        if(input[left] == c) return 0;
        else return 1;
    }
    int mid = (left + right)/2;
    int answ_left = count(c, left, mid) + answ(c + 1, mid, right);
    int answ_right = count(c, mid, right) + answ(c + 1, left, mid);

    return min(answ_right, answ_left);
}

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int t;
    cin >> t;
    while(t--){
        int n;
        cin >> n;
        cin >> input;
        cout << answ('a', 0, n) << "\n";
    }

	return 0;
}