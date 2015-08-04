#include <iostream>
#include <stdlib.h>

using namespace std;

struct vector{
    float x;
    float y;
    float z;

    };

float producto(struct vector v1,struct vector v2)
{struct vector vr;
float res;
vr.x = (v1.x) * (v2.x);
vr.y = (v1.y) * (v2.y);
vr.z = (v1.z) * (v2.z);
res = vr.x + vr.y + vr.z;
return res;}

int main(){
struct vector v1,v2;
float r;

cout<<"indique el 1er vector (a;b;c)"<<endl;
cout<<"a=";
cin>>v1.x;
cout<<"b=";
cin>>v1.y;
cout<<"c=";
cin>>v1.z;


cout<<"indique el 2do vector (d;e;f)"<<endl;
cout<<"d=";
cin>>v2.x;
cout<<"e=";
cin>>v2.y;
cout<<"f=";
cin>>v2.z;

r=producto(v1,v2);
cout<<"el producto de los vectores es "<<r;

  cout<<"\n";
  return 0;
}
