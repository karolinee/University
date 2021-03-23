#include <bits/stdc++.h>
using namespace std;



int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n, m;
    cin >> n >> m;

    if( n != m ) cout << "NO";
    else{
        vector<int> edges[n + 1];

        for(int i = 0; i < m; i++){
            int x,y;
            cin >> x >> y;
            edges[x].push_back(y);
            edges[y].push_back(x);
        }

        bool visited[n + 1];
        for(int i = 1; i <= n; i++){
            visited[i] = false;
        }

        stack<int> stack;
        stack.push(1);

        while(!stack.empty()){
            int tmp = stack.top();
            stack.pop();

            if(!visited[tmp]){
                visited[tmp] = true;
                for(int i: edges[tmp]) stack.push(i);
            }
        }

        bool connected = true;
        for(int i = 1; i <= n; i++){
            if(!visited[i]){
                connected = false;
                break;
            }
        }

        if(connected) cout << "FHTAGN!";
        else cout <<"NO";
    }

    

	return 0;
}