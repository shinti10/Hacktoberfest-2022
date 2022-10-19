	   #Dutch National Flag Algorithms
# Sort 0s,1s,2s(dnf algorithm)

->Given an array A[] consisting of only 0s, 1s, and 2s. The task is to write a function that sorts the given array. The functions should put all 0s first, then all 1s and all 2s in last.

->test cases
Input: {0, 1, 2, 0, 1, 2}
Output: {0, 0, 1, 1, 2, 2}

Input: {0, 1, 1, 0, 1, 2, 1, 2, 0, 0, 0, 1}
Output: {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2}

Recommended Problem
# C++ Program of dnf Sort :
// C++ implementation of dnf Sort
------------------------------

#include<iostream>
using namespace std;
void swap(int arr[],int i,int j)
{
    int temp=arr[i];
    arr[i]=arr[j];
    arr[j]=temp;
}
void dnssort(int arr[],int n)
{
    int low=0;
    int mid=0;
    int high=n-1;

while(mid<=high)
{
    if (arr[mid]==0)
    {
        swap(arr,low,mid);
        low++;
        mid++;
    }
    else if(arr[mid]==1)
    {
        mid++;
    }
    else{
        swap(arr,mid,high);
        high--;
    }

}
}
int main()
{
    int arr[]={1,0,2,1,0,1,2,1,2};
    dnssort(arr,9);
    for (int i = 0; i <9; i++)
    {
        cout<<arr[i]<<" ";
    }

    return 0;

}
--------------------------------------------------------
Time Complexity: O(n), Only nonnested traversals of the array are needed.
Space Complexity: O(1)
