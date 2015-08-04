#include <iostream>
#include <stdlib.h>

using namespace std;

void cifras(float n,int t){
float h=0;
do {
    n=n/10;
    h=h+1;
}
while(n>=1);

cout<<"el numero tiene "<<h<<" cifra(s) en base "<<t<<endl;}


int main()
{  int a,m,n,k=0,l=0;
    int h[k];

cout<<"ingrese el numero"<<endl;
cin>>n;
m=n;
cifras(n,10);


    do{
    h[k]=m%2;
    m=(m-h[k])/2;
    l=l+1;
    k=k+1;
}
while(m>=2);

    cout<<"el numero de cifras en base 2 es "<<l+1<<endl;
    cout<<"el numero en base 2 es :1";
    for(a=0;a<=(k-1);a++){
    cout<<h[k-1-a];}

  cout<<"\n";
  return 0;
}
