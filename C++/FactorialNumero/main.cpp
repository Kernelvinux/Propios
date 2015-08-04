#include <iostream>
#include <stdlib.h>

using namespace std;

int factorial(int a){
    if(a>=2)
    return (factorial(a-1)*a);
    else return 1;
}

int main(){
    int x;
    cout<<"ingrese el numero"<<endl;
    cin>>x;
    cout<<x<<"! = "<<factorial(x);

    cout<<"\n";
    return 0;
}
