#include <iostream>
#include <stdlib.h>

using namespace std;

int main()
{int i,j,N,sd=0;
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
        sd=A[j][j]+sd;}

        cout<<"la traza es: "<<sd;

  cout<<"\n";
  return 0;
}
