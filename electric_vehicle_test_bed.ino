/*
 * ultrasonic sensor stuff
 */
const int trigPin = 4;
const int echoPin = 5;
float duration, distance, motorspeed;

/*
 * motor stuff
 */
const int forward = 2;
const int backward = 3;
int headlights;
int outval = 0;
float testingmotorspeed,actualspeed;
/*
 *  water level sensor stuff
 */
const int sensorMin = 0;     // sensor minimum
const int sensorMax = 1024;  // sensor maximum
/*
 * temp and humidity stuff
 */
#include <dht.h>
dht DHT;
float temp, hum;
#define DHT11_PIN 37
/*
 * lcd stuff
 */
#include <LiquidCrystal.h>
LiquidCrystal lcd(8,9,10,11,12,13);
/*
 * ir remote stuff
 */
#include <IRremote.h>
#include <IRremoteInt.h>
IRrecv irrecv(33); //ir module pin connection
decode_results results;
long lastPressTime = 0;
int state = LOW;
int val = 0;

/*
 * rfid and buzzer stuff
 */
#include <SPI.h>
#include <MFRC522.h>
#define RST_PIN         6          
#define SS_PIN          53         
MFRC522 mfrc522(SS_PIN, RST_PIN);  // Create MFRC522 instance

const int buzzer = 7;


void setup() {
  /*
   * ultrasonic sensor
   */
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  /*
   * motor
   */
  pinMode(forward,OUTPUT);
  pinMode(backward,OUTPUT);
  /*
   * lcd
   */
  pinMode(26,OUTPUT);
  //analogWrite(26,120);
  lcd.begin(16,2);
  /*
   * ir remote
   */
  irrecv.enableIRIn();  //start the reciever

  /*
   * rfid and buzzer stuff
   */
  pinMode(buzzer, OUTPUT);  
  SPI.begin();      // Init SPI bus
  mfrc522.PCD_Init();   // Init MFRC522
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  if ( ! mfrc522.PICC_IsNewCardPresent()) {
    return;
  }
  // select one of the cards
  if ( ! mfrc522.PICC_ReadCardSerial()) {
    return;
  }
  String content = "";
  byte letter;
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
    content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  //Serial.println();
  //Serial.print("Message: ");
  content.toUpperCase();
  if (content.substring(1) == "60 52 D4 30") { //card id
    tone(buzzer, 500); // Send 1KHz sound signal...
    delay(1200);        // ...for 1 sec
    noTone(buzzer); 
    while (! mfrc522.PICC_IsNewCardPresent()) {  //if card is scanned, while no card is there, sound at 1000Hz
      lcd.setCursor(0,0);  
      lcd.write("Speed:");
      lcd.setCursor(12,0);  
      lcd.write("%");
      lcd.setCursor(0,1);  
      lcd.write("WL%:");
      lcd.setCursor(8,1);  
      lcd.write("T(C):");
      delay(2000);
      int sensorReading = analogRead(A0);
      int sensorrange = map(sensorReading, sensorMin, sensorMax, 0, 100);
      if (sensorrange < 30) {
        analogWrite(backward,0); // I want the dc motor to move in only one direction (forward)
      analogWrite(forward,0);
      }
      lcd.setCursor(4,1);  
      lcd.print(sensorrange);
      
      
      digitalWrite(trigPin, LOW);
      delayMicroseconds(2);
      digitalWrite(trigPin, HIGH);
      delayMicroseconds(10);
      digitalWrite(trigPin, LOW);
      duration = pulseIn(echoPin, HIGH);
      distance = (duration*.0343)/2;
      if (irrecv.decode(&results)) {
        if (results.value == 16769055) {
          motorspeed = motorspeed - 10;
          if (motorspeed<0) {
            motorspeed = 0;
          }
        }
        else if (results.value == 16748655) {
          motorspeed = motorspeed + 10;
          if (motorspeed > 100) {
            motorspeed = 100;
          }
        }
      }


      /*
       * headlights: 1 - off, 2 - dim, 3 - bright
       */
      if (irrecv.decode(&results)) {
        if (results.value == 16724175) {
          headlights = 1;
        }
        else if (results.value == 16718055) {
          headlights = 2;
        }
        else if (results.value == 16743045) {
          headlights = 3;
        }
      }


      
      lcd.setCursor(6,0); 
      lcd.print(motorspeed);
      actualspeed = (motorspeed/100)*distance;
      outval = map(actualspeed,0,30,0,255); // maybe i should change the mapping
      analogWrite(backward,0); // I want the dc motor to move in only one direction (forward)
      analogWrite(forward,outval);
      if (sensorrange < 30) {
        analogWrite(backward,0); // I want the dc motor to move in only one direction (forward)
      analogWrite(forward,0);
      }
    
      // temp and humidty loop stuff
      int chk = DHT.read11(DHT11_PIN);
      temp = DHT.temperature;
      hum = DHT.humidity;
      if (temp > 30) {
        analogWrite(backward,0); // I want the dc motor to move in only one direction (forward)
      analogWrite(forward,0);
      }
      
      lcd.setCursor(13,1);  
      lcd.print(String(int(temp)));
      
      irrecv.resume(); 
      Serial.println(String(distance) + " " + String(outval) + " " + String(sensorrange) + " " + String(temp) + " " + String(motorspeed) + " " + String(headlights)); 
    }
  }

  
  else { // when fob is scanned
    int distance = 0;
    int outval = 0;
    int sensorrange = 0;
    int temp = 0;
    int motorspeed = 0;
    int headlights = 0;
    tone(buzzer, 3000); // Send 1KHz sound signal...
    delay(200);        // ...for 1 sec
    noTone(buzzer);     // Stop sound...
    delay(100);
    tone(buzzer, 3000); // Send 1KHz sound signal...
    delay(200);        // ...for 1 sec
    noTone(buzzer); 
    delay(100);
    tone(buzzer, 3000); // Send 1KHz sound signal...
    delay(200);        // ...for 1 sec
    noTone(buzzer); 
    delay(100);
    tone(buzzer, 3000); // Send 1KHz sound signal...
    delay(500);        // ...for 1 sec
    noTone(buzzer);
    delay(1000); 
    analogWrite(backward,0); 
    analogWrite(forward,0);
    Serial.println(String(distance) + " " + String(outval) + " " + String(sensorrange) + " " + String(temp) + " " + String(motorspeed) + " " + String(headlights));
  }

  

   
}
