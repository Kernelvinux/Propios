#include <iostream>

using namespace std;

#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/features2d/features2d.hpp>

int main()
{
    double alpha = 0.5;
    double beta;
    double input;

    cv::Mat src1, src2, scr3, dst;

    //Se obtiene la transpariencia alpha
    std::cout<<"Introduce Alpha [0-1]: ";
    std::cin>>input;

    //Comprobamos que Alpha se encuentra entre 0 y 1
    if (alpha >= 0 && alpha <= 1)
    { alpha = input; }

     // Leemos la imagen (mismos pixels en 'x' y en 'y', mismo tipo)
     src1 = cv::imread( "/home/piero/Repositorios/Propios/C++/OpenCV/Prueba1/PruebaOpenCV/1.png");
     src2 = cv::imread( "/home/piero/Repositorios/Propios/C++/OpenCV/Prueba1/PruebaOpenCV/1.png");

     // Si hay error de lectura mostramos el error
     if( !src1.data ) { std::cout<<"Error loading src1 n"; return -1; }
     if( !src2.data ) { std::cout<<"Error loading src2 n"; return -1; }

     // Creamos una ventana
     cv::namedWindow("Linear Blend", 1);

     // Obtenemos Beta
     beta = ( 1.0 - alpha );

     // Aplicamos el algoritmo de mezcla
     cv::addWeighted( src1, alpha, src2, beta, 0.0, dst);

     // Y la mostramos en una ventana
     cv::imshow( "Linear Blend", dst );

     cv::waitKey(0);
     return 0;
    }
