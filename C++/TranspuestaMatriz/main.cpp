#include <iostream>
#include <stdlib.h>

using namespace std;

int main(){
    int i,j,N,M;
    float A[N][M];
    cout<<"ingrese el numero de filas \n";
    cin>>N;
    cout<<"ingrese el numero de columnas \n";
    cin>>M;

    for(j=1;j<=M;j++)
    {for(i=1;i<=N;i++)
    {    cout<<"A["<<i<<"]["<<j<<"]=";
        cin>>A[i][j];
    }
    cout<<endl;
}
cout<<"La matriz transpuesta de A es \n\n";
for(i=1;i<=M;i++)
{for(j=1;j<=N;j++)
{   cout<<A[j][i]<<"\t";
    }cout<<endl;
}



 cout<<"\n";
  return 0;
}
