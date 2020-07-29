//declare switch pin
int switchPin = 4;

void setup() {
  //set pin to input and open serial communication
  pinMode(switchPin, INPUT);
  Serial.begin(9600);

}

void loop() {
  //write out whether or not the button has been pressed
  int switchOut = digitalRead(switchPin);
  Serial.write(switchOut);

  delay(50);
}
