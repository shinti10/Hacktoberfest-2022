#include <bits/stdc++.h>
using namespace std;
int main()
{
    int prices[] = {7, 6, 4, 3, 1};
    int n = sizeof(prices) / sizeof(prices[0]);
    int j, low = INT_MAX, high = INT_MIN;
    for (int i = 0; i < n; i++)
    {
        low = min(low, prices[i]);
        j = i;
    }
    if (j != n-1)
    {
        for (int i = j; i <= n; i++)
        {
            high = max(high, prices[i]);
        }
        cout << high - low << endl;
    }
    else
    {
        cout<<"0\n";
    }
    return 0;
}