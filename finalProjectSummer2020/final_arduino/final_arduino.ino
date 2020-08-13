#include "FastLED.h"

#define NUM_LEDS 250
#define DATA_PIN 7

char pitchChar; // Data received from the serial port
char ampChar;

CRGB leds[NUM_LEDS];

String processing;
int pitch;
int amp;
int amp2;

int currentValue = 0;
int values[] = {0, 0};

void setup() {
  Serial.begin(115200); // Start serial communication at 9600 bps
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
}

void loop() {

  if (Serial.available())
  { // If data is available to read,

    int incomingValue = Serial.read();

    values[currentValue] = incomingValue;

    currentValue++;
    if (currentValue > 1) {
      currentValue = 0;
    }

    amp = values[0];
    pitch = values[1];
  }
  FastLED.clear();


  FastLED.setBrightness(amp);

  if (pitch == 111) {
    fill_solid( leds, NUM_LEDS, CRGB(255, 165, 0));
  }
  else if (pitch == 112) {
    fill_solid( leds, NUM_LEDS, CRGB( 0, 128, 0));
  }
  else if (pitch == 113) {
    fill_solid( leds, NUM_LEDS, CRGB(64, 224, 208));
  }
  else if (pitch == 114) {
    fill_solid( leds, NUM_LEDS, CRGB(255, 192, 203));
  }
  else if (pitch == 115) {
    fill_solid( leds, NUM_LEDS, CRGB(255, 255, 0));
  }
  else if (pitch == 116) {
    fill_solid( leds, NUM_LEDS, CRGB(147, 112, 219));
  }
  else if (pitch == 117) {
    fill_solid( leds, NUM_LEDS, CRGB(0, 0, 255));
  }

  else if (pitch == 11) {
    for (int i = 100; i < 154; i++ )
    {
      leds[i].setRGB(255, 165, 0);
    }
  }
  else if (pitch == 22) {
    for (int i = 100; i < 154; i++ )
    {
      leds[i].setRGB(0, 128, 0);
    }
  }
  else if (pitch == 33) {
    for (int i = 100; i < 154; i++ )
    {
      leds[i].setRGB(64, 224, 208);
    }
  }
  else if (pitch == 44) {
    for (int i = 100; i < 154; i++ )
    {
      leds[i].setRGB(255, 192, 203);
    }
  }
  else if (pitch == 55) {
    for (int i = 100; i < 154; i++ )
    {
      leds[i].setRGB(255, 255, 0);
    }
  }
  else if (pitch == 66) {
    for (int i = 100; i < 154; i++ )
    {
      leds[i].setRGB(147, 112, 219);
    }
  }
  else if (pitch == 77) {
    for (int i = 100; i < 154; i++ )
    {
      leds[i].setRGB(0, 0, 255);
    }
  }

  else if (pitch == 1) {
    for (int i = 120; i < 134; i++ )
    {
      leds[i].setRGB(255, 165, 0);
    }
  }

  else if (pitch == 2) {
    for (int i = 120; i < 134; i++ )
    {
      leds[i].setRGB(0, 128, 0);
    }
  }

  else if (pitch == 3) {
    for (int i = 120; i < 134; i++ )
    {
      leds[i].setRGB(64, 224, 208);
    }
  }

  else if (pitch == 4) {
    for (int i = 120; i < 134; i++ )
    {
      leds[i].setRGB(255, 192, 203);
    }
  }

  else if (pitch == 5) {
    for (int i = 120; i < 134; i++ )
    {
      leds[i].setRGB(255, 255, 0);
    }
  }

  else if (pitch == 6) {
    for (int i = 120; i < 134; i++ )
    {
      leds[i].setRGB(147, 112, 219);
    }
  }

  else if (pitch == 7) {
    for (int i = 120; i < 134; i++ )
    {
      leds[i].setRGB(0, 0, 255);
    }

  }

  else if (pitch == 0) {
    for (int i = 0; i < 250; i++ )
    {
      leds[i].setRGB(255, 255, 250);
    }
  }

  FastLED.show();

}
