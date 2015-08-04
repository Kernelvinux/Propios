/*
TUTORIAL DE ARDUINO Y SHARP
 
Enciende el LED del pin 13 si el sensor IR detecta
un objeto.
*/
 
#define LED 4 //definimos el pin del LED
 
int dist = 0; //aqui guardamos el valor del sensor
 
void setup()
{
pinMode(LED, OUTPUT);
Serial.begin(9600);
}
 
void loop()
{
dist = analogRead(A6); //Leemos A4 y almacenamos su valor
Serial.println(dist); //Escribimos dist por serial
 
if(dist > 350) digitalWrite(LED, HIGH);
else digitalWrite(LED, LOW);
 
delay(1000);
}
