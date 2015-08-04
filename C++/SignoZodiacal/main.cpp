#include <cstdlib>
#include <iostream>

using namespace std;

int main()
{
    int a,b;
    cout<<"ingrese su fecha de nacimiento(dd/mm) : \n";
    cin>>a;
    cin>>b;
  if (a<=31){

    switch(b)  {
           case 1:{
                if(a<=19)
                cout<<"su signo es capricornio";
                else
                cout<<"su signo es acuario";}
                break;

           case 2:{
                if(a<=17)
                cout<<"su signo es acuario";
                else
                cout<<"su signo es piscis";}
                break;

           case 3 :{
                if(a<=19)
                cout<<"su signo es piscis";
                else
                cout<<"su signo es aries";}
                break;

           case 4:{
                if(a<=19)
                cout<<"su signo es aries";
                else
                cout<<"su signo es tauro";}
                break;

           case 5:{
                if(a<=20)
                cout<<"su signo es tauro";
                else
                cout<<"su signo es geminis";}
                break;

           case 6:{
                if(a<=20)
                cout<<"su signo es geminis";
                else
                cout<<"su signo es cancer";}
                break;

           case 7:{
                if(a<=22)
                cout<<"su signo es cancer";
                else
                cout<<"su signo es leo";}
                break;

           case 8:{
                if(a<=22)
                cout<<"su signo es leo";
                else
                cout<<"su signo es virgo";}
                break;

           case 9:{
                if(a<=22)
                cout<<"su signo es virgo";
                else
                cout<<"su signo es libra";}
                break;

           case 10:{
                if(a<=22)
                cout<<"su signo es libra";
                else
                cout<<"su signo es escorpio";}
                break;

           case 11:{
                if(a<=21)
                cout<<"su signo es escorpio";
                else
                cout<<"su signo es sagitario";}
                break;

           case 12:{
                if(a<=21)
                cout<<"su signo es sagitario";
                else
                cout<<"su signo es capricornio";}
                break;

                }}

          else
              cout<<"ese dia no existe";

    cout<<"\n";
    return EXIT_SUCCESS;
}
