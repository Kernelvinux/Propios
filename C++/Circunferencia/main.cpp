#include <iostream>
#include <stdlib.h>
#include <math.h>

using namespace std;

float pi=3.1416;

struct punto{
    double x;
    double y;
    };

struct circunferencia{
    struct punto centro;
    double radio;
};


double perimetro(struct circunferencia c){
    return 2*pi*c.radio;
}

double area(struct circunferencia c){
    return pi*c.radio*c.radio;
}

double distancia(struct circunferencia c1,struct circunferencia c2){
    return sqrt( pow(c2.centro.y-c1.centro.y,2)+pow(c2.centro.x-c2.centro.y,2) );
}


int main(void)
{struct circunferencia c1,c2;
double d,p1,p2,a1,a2;

cout<<"introduzca la coordenadas del 1er centro (x;y)"<<endl;
cout<<"x=";
cin>>c1.centro.x;
cout<<"y=";
cin>>c1.centro.y;
cout<<"introduzca el radio de la 1era circunferencia: ";
cin>>c1.radio;


cout<<endl<<"introduzca la coordenadas del 2do centro (h;k)"<<endl;
cout<<"h=";
cin>>c2.centro.x;
cout<<"k=";
cin>>c2.centro.y;
cout<<"introduzca el radio de la 2da circunferencia: ";
cin>>c2.radio;

    d=distancia(c1,c2);
    cout<<endl<<"la distancia entre los centros es "<<d<<endl;
    p1=perimetro(c1);
    p2=perimetro(c2);
    a1=area(c1);
    a2=area(c2);
    cout<<"el perimetro de la 1era circunferencia es "<<p1<<endl<<"el perimetro de la 2da circunferencia es "<<p2<<endl;
    cout<<"el area de la 1era circunferencia es "<<a1<<endl<<"el area de la 2da circunferencia es "<<a2<<endl;


  cout<<"\n";
  return 0;
}

