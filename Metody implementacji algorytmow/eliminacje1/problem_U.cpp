#include <bits/stdc++.h>
using namespace std;


int main () {
  	ios_base::sync_with_stdio(false);
  	cin.tie(NULL);
	int t;
	cin >> t;
    while (t--) {
        int n;
        cin >> n;
        map<string, int> teams;
      	for(int i = 0; i < n; i++) {
        	string tmp;
          	cin >> tmp;
         	teams[tmp] = i;
        }
        int end = 0;
        int start = 0;
      	for(int i = 0; i < n; i++) {
          	string tmp;
          	cin >> tmp;
          	int idx = teams[tmp];
          	if(idx > i) {
                  end = max(idx, end);
              }
            if(i == end) {
                cout << end - start + 1 << " ";
                start = i + 1;
                end = start;
            }   
        }
        cout << "\n";

    }

    return 0;
}
