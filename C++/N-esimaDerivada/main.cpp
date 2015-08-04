#include <iostream>
#include <stdlib.h>

using namespace std;

int factorial(int a)
{if(a>=2)
return (factorial(a-1)*a);
else return 1;
}

void leer_coeficientes(float M[],int h)
{int a;
for(a=0;a<=h;a++){
        cout<<"coeficiente"<<a<<"=";
        cin>>M[a];}
    }

void derivada(int m,int n, float A[]){
    int l,r;
for(l=0;l<=n;l++){
    r=(factorial(l)/factorial(l-m))*A[l];
    if((l-m)>=0)
    cout<<"el coeficiente del x a la "<<l-m<<" es: "<<r<<endl;}
}

int main()
{int n,m;
    float A[n];

     cout<<"ingrese el grado de su polinomio \n";
    cin>>n;



    cout<<"ingrese los coeficientes de su polinomio, empezando del termino independiente hasta el coeficiente principal en el orden del grado de la variable \n";
    leer_coeficientes(A,n);




    cout<<"ingrese que derivada desea de su polinomio"<<endl;
    cin>>m;
    derivada(m,n,A);


  return 0;
}
