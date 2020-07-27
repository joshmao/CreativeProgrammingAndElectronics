//Josh Mao Des Inv 23 Instrument; buttons + servo combo inspired by (https://www.instructables.com/id/Servo-Motor-Arduino/)

//import servo library
#include <Servo.h>;

// pushbutton pins
const int buttonPin = 8;
const int button2Pin = 2;

// servo pin
const int servoPin = 3;

//piezo pin
const int piezoPin = 4;

//create servo object
Servo servo;

void setup()
{
  servo.attach (servoPin);

  // Set up the pushbutton pins to be inputs:
  pinMode(buttonPin, INPUT);
  pinMode(button2Pin, INPUT);

}

void loop()
{
  //read the digital state of the pins with digitalRead() function
  int buttonState = digitalRead(buttonPin);
  int button2State = digitalRead(button2Pin);

  //when first button is pressed, turn servo to random degree
  if (buttonState == LOW) {
    int angles = random(180);
    servo.write(angles);
  }

  //convert servo degree to hertz
  int servoData = servo.read();
  int servoConverted = map(servoData, 0, 180, 31, 4978);
  tone(piezoPin, servoConverted);

  //if second button is pressed, play no tone from the piezo
  if (button2State == LOW) {
    noTone(piezoPin);
  }
}
