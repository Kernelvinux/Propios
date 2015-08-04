#include <iostream>
#include <stdlib.h>

using namespace std;

int fibonacci(int a){
    if(a>1)
        return (fibonacci(a-1)+fibonacci(a-2));
    else {
        if (a==1) return 1;
        else return 0;}
}

int main(){
    int x;
    cout<<"ingrese el termino que desea observar"<<endl;
    cin>>x;
    cout<<fibonacci(x);

    cout<<"\n";
    return 0;
}


