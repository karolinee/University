#include <bits/stdc++.h>
using namespace std;
const int N = 100005;
int arr[N];
long long tree[N*4];
int op[N][3];
int q[N][2];


void update(int b, int e, int idx, int low, int high, long long val){
    if(b == low && e == high){
        tree[idx] += val;
        return;
    }

    if(e <= b) return;


    int mid = (low+high)/2;
    int left = idx * 2; 
    int right = 2*idx+1;
    update(b, min(e, mid + 1), left, low, mid + 1, val);
    update(max(b, mid + 1), e, right, mid + 1, high, val);
}

long long getVal(int idx, int s, int size){
    long long res = arr[idx];

    idx = size - (int)pow(2, s) + idx;


    res += tree[idx];

    idx /= 2;
    while(idx > 0){
        res += tree[idx];
        idx /= 2;
    }
    return res;   
}

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

    int n, m, k;
    cin >> n >> m >> k;

    

    for(int i = 1; i <= n; i++){
        cin >> arr[i];
    }


    for(int i = 1; i <= m; i++){
        cin >> op[i][0] >> op[i][1] >> op[i][2];
    }

    int height = (int)(ceil(log2(n)));
    int max_size = 2*(int)(pow(2, height)) - 1;

    
    for(int i = 0; i < k; i++){
        int x, y;
        cin >> x >> y;
        while (x <= y)
        {
            int b = op[x][0];
            int e = op[x][1];
            int d = op[x][2];
            update(b,e+1,1,1,n+1,d);
            x++;
        }

    }

    for(int i = 1; i <= max_size; i++){
        cout << tree[i] << " ";
    }
    cout << endl;

    for(int i = 1; i <= n; i++){
        //cout << "iiii zaczynamy " << endl;
        cout << getVal(i, height, max_size) << " ";
    }
	return 0;
}