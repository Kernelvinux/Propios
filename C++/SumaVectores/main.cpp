#include <iostream>
#include <stdlib.h>

using namespace std;

struct vector{
    double x;
    double y;

    };

struct vector suma(struct vector v1,struct vector v2)
{struct vector vr;
vr.x = v1.x + v2.x;
vr.y = v1.y + v2.y;
return vr;}

int main()
{struct vector v1,v2,vres;

cout<<"indique el 1er vector (a;b)"<<endl;
cout<<"a=";
cin>>v1.x;
cout<<"b=";
cin>>v1.y;


cout<<"indique el 2do vector (c;d)"<<endl;
cout<<"c=";
cin>>v2.x;
cout<<"d=";
cin>>v2.y;

vres=suma(v1,v2);
cout<<"la suma de los vectores es ("<<vres.x<<";"<<vres.y<<")";

  cout<<"\n";
  return 0;
}
