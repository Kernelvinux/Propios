#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;
using namespace std;

int main(){
  VideoCapture cap(0);  // Especificamos el dispositivo a utilizar (cámara)

  if(!cap.isOpened())  // check if we succeeded
      return -1;

  Mat img = Mat::zeros(Size(320,240), CV_8UC3); // Se declara una variable de tipo Mat de tamaño 320x240
                                                // con 3 canales (rojo, verde, azul - imagen a color) en la cual guardaremos
                                                // y procesaremos la imagen.
  Mat gray = Mat::zeros(Size(320,240), CV_8UC1);  // imagen en escala de grises
  Mat edges = Mat::zeros(Size(320,240), CV_8UC1); // imagen con contornos, de un canal

  namedWindow("Preview");
  namedWindow("PostProcess");

  /* Creamos un ciclo infinito para mostrar la imagen*/
  for(;;){
    cap >> img;
    imshow("Preview", img);  // Se muestra la imagen capturada en la ventana Preview

    cvtColor(img, gray, CV_RGB2GRAY);  // se transforma la imagen, de RGB a una imagen en escala de grises

    Canny(gray, edges, 50, 200, 3);    // se aplica el método de canny para la detección de contornos
    imshow("PostProcess", edges);             // se muestra la imagen con los contornos

    int c = waitKey(30);  // Tiempo de espera de 30 milisegundos (muy necesario para que se vea algo)
    if(c == 27)           // Si presionamos Esc, termina.
      break;
  }
  return(1);
}
