//Josh Mao Des Inv 23 Midterm Video Project "Deconstruction"
//inspired by a variety of OpenCV examples, primarily Morphology Operations (https://github.com/atduskgreg/opencv-processing#morphologyoperations)

//importing libraries
import processing.video.*;
import gab.opencv.*;
import processing.serial.*;

Serial myPort; //declare myport object
Capture video; //declare video object
OpenCV opencv; //declare opencv object

//instruction text
String instructions = "Left Click - Opening \n Right Click - Closing \n Middle Click - Blurring" 
  + "\n Horizontal Movement - Flip Horizontally \n Vertical Movement - Flip Vertically"
  + "\n Press any Key to Begin & Scroll to Reset.";

//default values for video effects
int counterClose = 1;
int counterOpen =  1;
int counterBlur = 1;

void setup() {
  size(320, 180); //laptop webcam dimensions

  myPort  =  new Serial (this, "COM4", 9600); // Set the com port and the baud rate according to the Arduino IDE

  //instructions typography
  PFont f = createFont("Arial", 30);
  textFont(f, 15);
  fill(0);
  textAlign(CENTER);
  text(instructions, width/2, height/4.5);

  video = new Capture(this, width, height); //initialize video object
  opencv = new OpenCV(this, width, height); //initialize opencv object
}

//make sure video exists before reading the video
void captureEvent(Capture video) {
  video.read();
}

void draw() {

  opencv.loadImage(video); //grab frame from video capture
  opencv.useColor(); //use color version of image

  opencv.flip((int)map(mouseX, 0, width, -2, 0)); //moving mouse horizontally flips video horizontally
  opencv.flip((int)map(mouseY, 0, height, 0, 2)); //moving mouse vertically flips video vertically

  //different video effects that correspond to mouse events
  opencv.close(counterClose);
  opencv.open(counterOpen);
  opencv.blur(counterBlur);

  image(opencv.getOutput(), 0, 0); //display image after going through openCV functions
  
  //reading arduino serial data to blur if switch is pressed
  if (myPort.available() > 0) {
    int val = myPort.read();
    if (val == 1) {
      counterBlur += 1;
    }
  }
}

//functionality for Left Click - Closing, Right Click - Opening, and Center Click - Blurring
void mousePressed() {
  if (mouseButton == LEFT) {
    counterClose += 4;
  } else if (mouseButton == RIGHT) {
    counterOpen += 4;
  } //else if (mouseButton == CENTER) {
  //counterBlur += 1;
  //}
}

//resets every effect
void mouseWheel() {
  counterClose = 1;
  counterOpen = 1;
  counterBlur = 1;
}


//gets rid of instructions and starts video
void keyPressed() {
  video.start(); //start capture
}
