#include <bits/stdc++.h>
using namespace std;



int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n, m;
    cin >> n >> m;

    vector<int> know[m + 1];

    int know_none = 0;
    for(int i = 1; i <= n; i++){
        int tmp;
        cin >> tmp;
        if(tmp == 0) {
            know_none++;
        }
        else{
            for(int j = 1; j <= tmp; j++){
                int lang;
                cin >> lang;
                know[lang].push_back(i);
            }
        }
    }
    
    vector<int> can_com[n+1];
    for(int i = 1; i <= m; i++){
        for(int j : know[i]){
            for(int k : know[i]){
                if(j != k) can_com[j].push_back(k);
            }
        }
    }
    
    bool visited[n + 1];
    for(int i = 1; i <= n; i++){
            visited[i] = false;
    }

    int unvisited = n;
    int res = 0;
    while(unvisited > 0){
        res++;
        int idx = 1;
        while(visited[idx]) idx++;

        stack<int> stack;
        stack.push(idx);

        while(!stack.empty()){
            int tmp = stack.top();
            stack.pop();

            if(!visited[tmp]){
                visited[tmp] = true;
                unvisited--;
                for(int i: can_com[tmp]) stack.push(i);
            }
        }

    }

    if(know_none == n) cout<<n;
    else cout << res - 1;
    

    

	return 0;
}