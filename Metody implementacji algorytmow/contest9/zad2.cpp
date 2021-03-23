#include <bits/stdc++.h>
using namespace std;
int sieve[1000001];
long long primesSum[1000001];

void makeSieve(int b){
    sieve[1] = 1;
    for(int i = 2; i * i <= b; i++){
        if(!sieve[i]){
            for(int j = i + i; j <= b; j+= i){
                sieve[j] = 1;
            }
        }
    }
}
void makeSum(int b){
    primesSum[1] = 0;
    for(int i = 2; i <= b; i++){
        primesSum[i] = primesSum[i-1];
        if(!sieve[i]) primesSum[i]++;
    }
}

bool check(int a, int b, int l, int k){
    for(int i = a; i <= b - l + 1; i++){
        if(primesSum[i + l - 1] - primesSum[i - 1] < k) return false;
    }
    return true;
}

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
    
    int a,b,k;
    cin >> a >> b >> k;

    makeSieve(b);
    makeSum(b);    

    int res = -1;
    int low = k;
    int high = b - a + 1;

    while (low <= high)
    {
        int mid = (low + high)/2;
        if(check(a,b,mid,k)){
            if(res == -1){
                res = mid;
            }
            else{
                res = min(res, mid);
            }
            high = mid - 1;
        }
        else{
            low = mid + 1;
        }
    }
    


    cout << res;

    
	return 0;
}