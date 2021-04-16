#include <IRremote.h>

// emissor infravermelho
IRsend irsend;

// botoes
int A_inPin = 9;         // the number of the input pin
int B_inPin = 10;

// variavel que recebera dados do joystick
int port_x;
int port_y;

void setup() {
  Serial.begin(9600);
  pinMode(A_inPin, INPUT);
  pinMode(B_inPin, INPUT);
}

void loop() {
  port_x = analogRead(1);   //port recebe dados do joy
  port_y = analogRead(0);   //port recebe dados do joy 
  
  if(port_x < 250) {
    Serial.println("direita");    
    irsend.sendSony(B001, 3);  // 0x001 em 12 bits
  } else if(port_x > 750) {
    Serial.println("esquerda");  
    irsend.sendSony(B010, 3);  // 0x001 em 12 bits    
  }
  
  if(port_y < 250) {
    Serial.println("cima");   
    irsend.sendSony(B011, 3);  // 0x001 em 12 bits    
  } else if(port_y > 750) {
    Serial.println("baixo");  
    irsend.sendSony(B100, 3);  // 0x001 em 12 bits    
  }  
//  Serial.print("X: ");  
//  Serial.println(port_x);
//  
//  Serial.print("Y: ");  
//  Serial.println(port_y);   
  
  if(digitalRead(A_inPin) == 1) {
    Serial.println("pressionou A");
    irsend.sendSony(B101, 3);  // 0x001 em 12 bits    
  }
  if(digitalRead(B_inPin) == 1) {
    Serial.println("pressionou B");
    irsend.sendSony(B110, 3);  // 0x001 em 12 bits    
  }
  delay(80);   // 15 um pequeno atraso na progamação para tornar o controle "mais humano"   
}

