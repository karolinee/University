#include <bits/stdc++.h>
using namespace std;

int INF = 1000;
int mod = 1000000007;

int main(){
    /*ios_base::sync_with_stdio(false);
	cin.tie(NULL);*/
	
    int n;
    cin >> n;

    int arr[n][n];

    for(int i = 0; i< n; i++){
        string temp;
        cin >> temp;
        for(int j = 0; j < n; j++){
            arr[i][j] = temp[j] - '0';
        }
    }

    /*int distance[n][n] = {};
    int counter;
    for(int i = 0; i< n; i++){
        counter = 0;
        for(int j = 0; j < n; j++){
            distance[i][j] = INF;
            if(arr[i][j] == 0){
                distance[i][j] = 0;
                counter = 1;
            }
            else if(counter > 0){
                distance[i][j] = counter;
                counter++;
            }
            if(j < distance[i][j]){
                distance[i][j] = j;
            }
        }
    }
    for(int i = 0; i< n; i++){
        counter = 0;
        for(int j = n - 1; j >= 0; j--){
            if(arr[i][j] == 0){
                distance[i][j] = 0;
                counter = 1;
            }
            else if(counter > 0){
                if(counter < distance[i][j]){
                    distance[i][j] = counter;
                }
                counter++;
            }
            if(n-j-1 < distance[i][j]){
                distance[i][j] = n-j-1;
            }
        }
    }
    for(int j = 0; j< n; j++){
        counter = 0;
        for(int i = 0; i < n; i++){
            if(arr[i][j] == 0){
                counter = 1;
            }
            else if(counter > 0){
                if(counter < distance[i][j]){
                    distance[i][j] = counter;
                }
                counter++;
            }
            if(i < distance[i][j]){
                distance[i][j] = i;
            }
        }
    }
    for(int j = 0; j< n; j++){
        counter = 0;
        for(int i = n - 1; i >= 0; i--){
            if(arr[i][j] == 0){
                counter = 1;
            }
            else if(counter > 0){
                if(counter < distance[i][j]){
                    distance[i][j] = counter;
                }
                counter++;
            }
            if(n-i-1 < distance[i][j]){
                distance[i][j] = n-i-1;
            }
        }
    }
    double max = -100000;
    for(int i = 0; i< n; i++){
        for(int j = 0; j < n; j++){
            int d = distance[i][j];
            int result = arr[i][j];
            while(d > 0){
                result *= arr[i+d][j] % mod;
                result *= arr[i-d][j] % mod;
                result *= arr[i][j+d] % mod;
                result *= arr[i][j-d] % mod;
                d--;
            }
            if (result > max){
                max = result;
            }
        }
    }*/


    /*int distancex[n][n] = {};

    int counter;
    for(int i = 0; i< n; i++){
        counter = 0;
        for(int j = 0; j < n; j++){
            distance[i][j] = INF;
            if(arr[i][j] == 0){
                distance[i][j] = 0;
                counter = 1;
            }
            else if(counter > 0){
                distance[i][j] = counter;
                counter++;
            }
            if(j < distance[i][j]){
                distance[i][j] = j;
            }
        }
    }
    for(int i = 0; i< n; i++){
        counter = 0;
        for(int j = n - 1; j >= 0; j--){
            if(arr[i][j] == 0){
                distance[i][j] = 0;
                counter = 1;
            }
            else if(counter > 0){
                if(counter < distance[i][j]){
                    distance[i][j] = counter;
                }
                counter++;
            }
            if(n-j-1 < distance[i][j]){
                distance[i][j] = n-j-1;
            }
        }
    }
    for(int j = 0; j< n; j++){
        counter = 0;
        for(int i = 0; i < n; i++){
            if(arr[i][j] == 0){
                counter = 1;
            }
            else if(counter > 0){
                if(counter < distance[i][j]){
                    distance[i][j] = counter;
                }
                counter++;
            }
            if(i < distance[i][j]){
                distance[i][j] = i;
            }
        }
    }
    for(int j = 0; j< n; j++){
        counter = 0;
        for(int i = n - 1; i >= 0; i--){
            if(arr[i][j] == 0){
                counter = 1;
            }
            else if(counter > 0){
                if(counter < distance[i][j]){
                    distance[i][j] = counter;
                }
                counter++;
            }
            if(n-i-1 < distance[i][j]){
                distance[i][j] = n-i-1;
            }
        }
    }
    double max = -100000;
    for(int i = 0; i< n; i++){
        for(int j = 0; j < n; j++){
            int d = distance[i][j];
            int result = arr[i][j];
            while(d > 0){
                result *= arr[i+d][j] % mod;
                result *= arr[i-d][j] % mod;
                result *= arr[i][j+d] % mod;
                result *= arr[i][j-d] % mod;
                d--;
            }
            if (result > max){
                max = result;
            }
        }
    }*/

   /* int distancex[n][n] = {};

    int counter;
    for(int i = 0; i< n; i++){
        counter = 0;
        for(int j = 0; j < i; j++){
            distance[i][j] = INF;
            if(arr[i][j] == 0){
                distance[i][j] = 0;
                counter = 1;
            }
            else if(counter > 0){
                distance[i][j] = counter;
                counter++;
            }
            if(j < distance[i][j]){
                distance[i][j] = j;
            }
        }
    }*/




    /*or(int i = 0; i< n; i++){
        for(int j = 0; j < n; j++){
            cout << distance[i][j];
        }
        cout << "\n";
    }*/

    //cout << max; 

    
	return 0;
}


