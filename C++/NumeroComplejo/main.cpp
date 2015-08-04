#include <iostream>
#include <stdlib.h>

using namespace std;

struct complejo {
    double a;
    double b;
};

struct complejo suma_c(struct complejo c1,struct complejo c2){
    struct complejo c3;
    c3.a=c1.a+c2.a;
    c3.b=c1.b+c2.b;
    return c3;}

struct complejo resta_c(struct complejo c1,struct complejo c2){
    struct complejo c3;
    c3.a=c1.a-c2.a;
    c3.b=c1.b-c2.b;
    return c3;}

double real_c(struct complejo c1){
    return c1.a;}

double imag_c(struct complejo c1){
    return c1.b;}

int main(){
struct complejo c1,c2,s,r;
double e1,i1,e2,i2;

cout<<"introduzca el 1er complejo (a;b): "<<endl;
cout<<"a=";
cin>>c1.a;
cout<<"b=";
cin>>c1.b;

cout<<"introduzca el 2do complejo (c;d): "<<endl;
cout<<"c=";
cin>>c2.a;
cout<<"d=";
cin>>c2.b;

s=suma_c(c1,c2);
r=resta_c(c1,c2);
e1=real_c(c1);
e2=real_c(c2);
i1=imag_c(c1);
i2=imag_c(c2);

cout<<"la suma es: ("<<s.a<<","<<s.b<<")"<<endl;
cout<<"la resta es: ("<<r.a<<","<<r.b<<")"<<endl;
cout<<"la parte real del 1er complejo es: "<<e1<<" y la imaginaria es: "<<i1<<endl;
cout<<"la parte real del 2do complejo es: "<<e2<<" y la imaginaria es: "<<i2<<endl;

  cout<<"\n";
  return 0;
}
