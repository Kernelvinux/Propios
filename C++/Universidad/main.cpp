#include<iostream> //cabeceras
#include<math.h>

using namespace std;

int main() //inicio
{
    int a;
    cout<<"Para usted, cual es la mejor universidad del peru??"<<"\n";
    cout<<"1-Universidad Nacional Mayor de San Marcos"<<"\n";
    cout<<"2-Universidad Nacional de Ingenieria"<<"\n";
    cout<<"3-Pontificia Universidad Catolica del Peru"<<"\n";
    cout<<"4-Universidad Peruana de Ciencias Aplicadas"<<endl;


    do{
    cin>>a;
    if(a==2)
    cout<<"respuesta correcta, tu si sabes del tema!";
    else
    cout<<"respuesta incorrecta intenta nuevamente"<<endl;
     }
    while(a!=2);



  cout<<"\n";
  return 0;
}
