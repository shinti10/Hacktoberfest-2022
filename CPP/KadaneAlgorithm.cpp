#include <bits/stdc++.h>
using namespace std;

class Solution
{
public:
    // arr: input array
    // n: size of array
    //Function to find the sum of contiguous subarray with maximum sum.
    int maxSubarraySum(int arr[], int n)
    {

        // Your code here
        int msf = INT_MIN, meh = 0;
        for (int i = 0; i < n; i++)
        {
            meh = meh + arr[i];
            if (meh < arr[i])
            {
                meh = arr[i];
            }
            if (msf < meh)
            {
                msf = meh;
            }
        }
        return msf;
    }
};