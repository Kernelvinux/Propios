#include <iostream>
#include <stdlib.h>
#include <math.h>

using namespace std;

void leer_coeficientes(float M[],int h){
int a;
for(a=0;a<=h;a++){
        cout<<"coeficiente"<<a<<"=";
        cin>>M[a];}
}

void antiderivada(int n, float A[],float B[]){
    int l;
    double r;
    for(l=0;l<=n;l++){
    r=(A[l]/(l+1));
    B[l]=r;}
}

int main(){
    int n,a;
    double P=0,x=10;
    float A[n],B[n];

    cout<<"ingrese el grado de su polinomio \n";
    cin>>n;

    cout<<"ingrese los coeficientes de su polinomio, empezando del termino independiente hasta el coeficiente principal en el orden del grado de la variable \n";
    leer_coeficientes(A,n);

    antiderivada(n,A,B);

    cout<<"la integral desde 0 hasta 10 de su polinomio es \n";

    for(a=0;a<=n;a++){
        P=(B[a]*pow(x,a+1))+ P;}


    cout<<P;

  cout<<"\n";
  return 0;
}
