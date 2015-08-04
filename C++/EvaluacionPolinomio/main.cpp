#include <iostream>
#include <stdlib.h>
#include <math.h>

using namespace std;

int main(void)
{
    int a,P=0,n;
    float x;

    cout<<"ingrese el grado de su polinomio \n";
    cin>>n;

    float A[n];

    cout<<"ingrese los coeficientes de su polinomio, empezando del termino independiente";
    cout<<endl;
    for(a=0;a<=n;a++){
        cout<<"coeficiente"<<a<<"=";
        cin>>A[a];}

        cout<<"ingrese el numero con el que desea evaluar su polinomio P(x) \n";
        cin>>x;

        for(a=0;a<=n;a++){
            P=(A[a]*pow(x,a))+ P;}

            cout<<"P("<<x<<") = "<<P;

  cout<<"\n";
  return 0;
}

