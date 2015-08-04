#include <iostream>
#include <stdlib.h>
#include <math.h>

using namespace std;

struct vector{
    double x;
    double y;
    double z;};

double producto_escalar(struct vector v1, struct vector v2){
    struct vector vs;
    double r;
    vs.x=v1.x*v2.x;
    vs.y=v1.y*v2.y;
    vs.z=v1.z*v2.z;
    r= vs.x + vs.y + vs.z;
    return r;}

double modulo(struct vector v1){
    return sqrt( pow(v1.x,2)+pow(v1.y,2)+pow(v1.z,2));}

float angulo(struct vector v1,struct vector v2){
    return (producto_escalar(v1,v2))/(modulo(v1)*modulo(v2));}

int main(int argc, char *argv[])
{
    struct vector v1,v2;
    double t;
    cout<<"ingrese el vector 1"<<endl;
    cin>>v1.x;
    cin>>v1.y;
    cin>>v1.z;

    cout<<"ingrese el vector 2"<<endl;
    cin>>v2.x;
    cin>>v2.y;
    cin>>v2.z;

    t=angulo(v1,v2);
    cout<<"el coseno del angulo que forman es "<<t<<endl;


  cout<<"\n";
  return 0;
}

