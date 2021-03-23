#include <bits/stdc++.h>
using namespace std;

int ask(int L, int R){
    int result;
    cout << "? " << L << " " << R << endl;
    cin >> result;
    return result;
}

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int N;
    cin >> N;

    int flamingos[N+1] = {};

    int all_flamingos = ask(1,N);
    
    flamingos[1] = all_flamingos - ask(2,N);
    all_flamingos -= flamingos[1];

    for(int i = 2; i <= N - 1; i++){
        flamingos[i] = ask(i-1, i) - flamingos[i-1];
        all_flamingos -= flamingos[i];
    }
    flamingos[N] = all_flamingos;

    cout << "!";
    for(int i = 1; i <= N; i++) {
        cout << " " << flamingos[i];
    }
    cout << endl;

	return 0;
}