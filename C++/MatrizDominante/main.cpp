#include <iostream>
#include <stdlib.h>

using namespace std;

int main()
{int i,j,N,st=0,sd=0;
    cout<<"ingrese el numero de filas y columnas de su matriz cuadrada \n";
    cin>>N;

    float A[N][N];

    for(j=1;j<=N;j++)
    {for(i=1;i<=N;i++)
    {    cout<<"A["<<i<<"]["<<j<<"]=";
        cin>>A[i][j];
    }
    cout<<endl;}

    for(j=1;j<=N;j++){
    for (i=1;i<=N;i++){
        if(A[i][j]>0){
            st=A[i][j]+st;}
            else
            st=(-1)*A[i][j]+st;}}

        for(j=1;j<=N;j++){
        sd=A[j][j]+sd;}

        if(st-sd>sd)
        cout<<"la matriz dada es estrictamente dominante";
        else
        cout<<"la matriz dada NO es estrictamente dominante";


  cout<<"\n";
  return 0;
}
