#include <iostream>
#include <stdlib.h>

using namespace std;

float potenciacion(float a, int b)          //Se implementar� una funci�n llamada potenciaci�n que realizar� la operaci�n
{
    while (b>1){
        return (a*potenciacion(a,b-1));}    //Se realiza la potenciaci�n de forma recursiva
    return a;
    }

int main(){
    float a;
    int b;
    cout<<"Se efectuara la siguiente potenciacion: a^b"<<endl;
    cout<<"Ingrese el valor de a: ";
    cin>>a;
    cout<<"Ingrese el valor de b: ";
    cin>>b;
    cout<<"El resultado de a^b es: "<<potenciacion(a, b);
    cout<<"\n";

  return 0;
}
