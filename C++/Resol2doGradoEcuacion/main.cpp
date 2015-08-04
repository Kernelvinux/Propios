#include<iostream> //cabeceras
//#include<conio.h>
#include<math.h>

using namespace std;

int main() //inicio
{float a,b,c,x1,x2,d;
cout<<"digita el a de tu ecuacion"<<"\n";
cout<<"no olvides que tu ecuacion es ax2 + bx +c \n";
cin>>a;
cout<<"ahora digita el b \n";
cin>>b;
cout<<"y por ultimo, el c \n";
cin>>c;
d=b*b-4*a*c;
if(d>=0){
    x1=(-b+sqrt(b*b-4*a*c))/2*a;
    x2=(-b-sqrt(b*b-4*a*c))/2*a;
    cout<<"el x1 es:"<<x1<<"\n";
    cout<<"el x2 es:"<<x2;
    }//fin del if
else
   cout<<"esa ecuacion tiene raices imaginarias, no existen"<<"\n";

return 0;}
