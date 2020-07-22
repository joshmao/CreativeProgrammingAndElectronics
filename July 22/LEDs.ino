//Josh Mao Des 23 LEDs

void setup() {
  Serial.begin(9600); // initialize serial communication at 9600 bits per second
  pinMode(LED_BUILTIN, OUTPUT); //set built in led as output device

}

void loop() {
  int sensorValue = analogRead(A2); //read input value on analog pin A2
  Serial.println(sensorValue); //print out A2 values in serial monitor

  //built in LED only turns on when there's a certain amount of brightness
  if (sensorValue > 583 && sensorValue < 587) {
    digitalWrite(LED_BUILTIN, HIGH); //turn on LED
  }
  else {
    digitalWrite(LED_BUILTIN, LOW); //turn off LED
  }

  delay(1); //delay for stability
}
