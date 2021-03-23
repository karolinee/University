#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n;
    cin >>n;

    string names[n +1];

    for(int i = 1; i <= n; i++){
        cin >> names[i];
    }

    vector<int> smaller[n+1]; //graf skierowany, jeżeli j nalezy do smaller[i] to znaczy że i jest lex mniejsze

    for(int i = 1; i < n; i++){

        cout << names[i] << " " << names[i+1] << endl;
        int len1 = names[i].length();
        int len2 = names[i + 1].length();

        bool diff = false;

        for(int j = 0; j < min(len1, len2); j++){
            if(names[i][j] != names[i+1][j]){
                smaller[names[i][j] - 'a'].push_back(names[i+1][j] - 'a');
                diff = true;
                break;
            }
        }
        cout << "no sq" <<endl;
        if(len1 > len2 && !diff){
            cout << "Impossible";
            exit(0);
        }
    }
    
    cout << "*************" << endl;
    bool visited['a'];
    bool color['a'];

    for(int i = 0; i < 'a'; i++){
        visited[i] = false;
        color[i] = false;
    }
    for(int i = 0; i < 'a'; i++){
        if(!visited[i]){           
            stack<int> stack;
            stack.push(i);

            while(!stack.empty()){
                int tmp = stack.top();
                stack.pop();

                if(!visited[tmp]){
                    visited[tmp] = true;
                    color[tmp] = true;

                    for(int j: smaller[tmp]){
                        if(visited[j] && color[j]){
                            cout << "Impossible";
                            exit(0);
                        } else {
                            stack.push(j);
                        }
                    }
                }
                color[tmp] = false;
            }
        }
    }




	return 0;
}