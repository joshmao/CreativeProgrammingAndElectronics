/* Utilizes R2D2 Pitch Processing program made by L. Anton-Canalis (info@luisanton.es)
 *
 * Interactive Piano Project by Josh Mao
 * Des Inv 23 Final Project Summer 2020
 *
 * Relies on Minim audio library
 * http://code.compartmental.net/tools/minim/
 */

import processing.opengl.*;
import processing.serial.*;

import javax.swing.JFileChooser;

import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.*;

Serial myPort;  // Create object from Serial class


//PitchDetectorAutocorrelation PD; //Autocorrelation
//PitchDetectorHPS PD; //Harmonic Product Spectrum -not working yet-
PitchDetectorFFT PD; // Naive
ToneGenerator TG;
AudioSource AS;
Minim minim;

//Some arrays just to smooth output frequencies with a simple median.
float []freq_buffer = new float[10];
float []sorted;
int freq_buffer_index = 0;

long last_t = -1;
float avg_level = 0;
float last_level = 0;
String filename;
float begin_playing_time = -1;


//pitch stuff
FloatList pitchList;
int DATALIMIT = 20;

//calibrating pitches

//c
float c0Key = 96.899414;
float c1Key = 193.79883;
float c2Key = 129.19922;
float c3Key = 258.39844;
float c4Key = 516.7969;
float c5Key = 1033.5938;

//d
float d0Key = 107.666016;
float d1Key = 215.33202;
float d2Key = 150.73242;
float d3Key = 290.69824;
float d4Key = 581.3965;
float d5Key = 1184.3262;

//e
float e0Key = 247.63184;
float e1Key = 161.49902;
float e2Key = 161.49902;
float e3Key = 322.99805;
float e4Key = 656.7627;
float e5Key = 1324.292;

//f
float f0Key = 172.26562;
float f1Key = 172.26562;
float f2Key = 172.26562;
float f3Key = 344.53125;
float f4Key = 699.8291;
float f5Key = 1399.6582;

//g
float g0Key = 96.899414;
float g1Key = 387.59766;
float g2Key = 193.79883;
float g3Key = 387.59766;
float g4Key = 775.1953;
float g5Key = 1561.1572;

//a
float a0Key = 107.666016;
float a1Key = 215.33203;
float a2Key = 215.33203;
float a3Key = 441.43066;
float a4Key = 872.0947;

//b
float b0Key = 118.43262;
float b1Key = 118.43262;
float b2Key = 247.63184;
float b3Key = 495.26367;
float b4Key = 979.76074;

void setup()
{
  myPort = new Serial(this, "COM4", 115200); //opening serial

  size(600, 500, P2D);
  minim = new Minim(this);
  minim.debugOn();

  pitchList = new FloatList(); //create a floatlist to take in pitch values from mic


  AS = new AudioSource(minim);

  /*
  // Choose .wav file to analyze
   boolean ok = false;
   while (!ok) {
   JFileChooser chooser = new JFileChooser();
   chooser.setFileFilter(chooser.getAcceptAllFileFilter());
   int returnVal = chooser.showOpenDialog(null);
   if (returnVal == JFileChooser.APPROVE_OPTION) {
   filename = chooser.getSelectedFile().getPath();
   AS.OpenAudioFile(chooser.getSelectedFile().getPath(), 5, 512); //1024 for AMDF
   ok = true;
   }
   }
   */

  // Comment the previous block and uncomment the next line for microphone input
  AS.OpenMicrophone();

  PD = new PitchDetectorFFT();
  PD.ConfigureFFT(2048, AS.GetSampleRate());
  //PD = new PitchDetectorAutocorrelation();  //This one uses Autocorrelation
  //PD = new PitchDetectorHPS(); //This one uses Harmonit Product Spectrum -not working yet-
  PD.SetSampleRate(AS.GetSampleRate());
  AS.SetListener(PD);
  //TG = new ToneGenerator (minim, AS.GetSampleRate());

  rectMode(CORNERS);
  background(0);
  fill(0);
  stroke(255);
}


void draw()
{
  if (begin_playing_time == -1)
    begin_playing_time = millis();

  float f = 0;
  float level = AS.GetLevel();
  long t = PD.GetTime();
  if (t == last_t) return;
  last_t = t;
  int xpos = (int)t % width;
  if (xpos >= width-1) {
    rect(0, 0, width, height);
  }

  f = PD.GetFrequency();

  //amplitude stuff
  float amp = AS.GetLevel();
  float amp2 = map(amp, 0, 0.3, 5, 240);
  int amp3 = (int) amp2;

  println(amp);

  /*freq_buffer[freq_buffer_index] = f;
   freq_buffer_index++;
   freq_buffer_index = freq_buffer_index % freq_buffer.length;
   sorted = sort(freq_buffer);
   
   f = sorted[5];*/


  //println(f);

  //creating pitch dataset
  if (pitchList.size() < DATALIMIT) {
    pitchList.append(f);
  } else {
    pitchList.remove(0);
    pitchList.append(f);
  }
  
  //Sending both values over Serial to Arduino
  int pitch = pitchDetection();
  byte out[] = new byte[2];
  out[0] = byte(amp3);
  out[1] = byte(pitch);
  myPort.write(out);
  println(out);

  //TG.SetFrequency(f);
  //TG.SetLevel(level * 10.0);

  stroke(level * 255.0 * 10.0);
  line(xpos, height, xpos, height - f / 5.0f);
  avg_level = level;
  last_level = f;
}

//single note check
boolean cKeyCheck() {
  return(pitchList.hasValue(c0Key) || pitchList.hasValue(c1Key) || pitchList.hasValue(c2Key) 
    || pitchList.hasValue(c3Key) || pitchList.hasValue(c4Key) || pitchList.hasValue(c5Key));
}

boolean dKeyCheck() {
  return(pitchList.hasValue(d0Key) || pitchList.hasValue(d1Key) || pitchList.hasValue(d2Key) 
    || pitchList.hasValue(d3Key) || pitchList.hasValue(d4Key) || pitchList.hasValue(d5Key));
}

boolean eKeyCheck() {
  return(pitchList.hasValue(e0Key) || pitchList.hasValue(e1Key) || pitchList.hasValue(e2Key) 
    || pitchList.hasValue(e3Key) || pitchList.hasValue(e4Key) || pitchList.hasValue(e5Key));
}

boolean fKeyCheck() {
  return (pitchList.hasValue(f0Key) || pitchList.hasValue(f1Key) || pitchList.hasValue(f2Key) 
    || pitchList.hasValue(f3Key) || pitchList.hasValue(f4Key) || pitchList.hasValue(f5Key));
}

boolean gKeyCheck() {
  return (pitchList.hasValue(g0Key) || pitchList.hasValue(g1Key) || pitchList.hasValue(g2Key) 
    || pitchList.hasValue(g3Key) || pitchList.hasValue(g4Key) || pitchList.hasValue(g5Key));
}

boolean aKeyCheck() {
  return(pitchList.hasValue(a0Key) || pitchList.hasValue(a1Key) || pitchList.hasValue(a2Key) 
    || pitchList.hasValue(a3Key) || pitchList.hasValue(a4Key));
}

boolean bKeyCheck() {
  return (pitchList.hasValue(b0Key) || pitchList.hasValue(b1Key) || pitchList.hasValue(b2Key) 
    || pitchList.hasValue(b3Key) || pitchList.hasValue(b4Key));
}

//double note check
boolean c2KeyCheck() {
  return (cKeyCheck() && eKeyCheck());
}

boolean d2KeyCheck() {
  return (dKeyCheck() && fKeyCheck());
}

boolean e2KeyCheck() {
  return (eKeyCheck() && gKeyCheck());
}

boolean f2KeyCheck() {
  return (fKeyCheck() && aKeyCheck());
}

boolean g2KeyCheck() {
  return (gKeyCheck() && bKeyCheck());
}

boolean a2KeyCheck() {
  return (aKeyCheck() && cKeyCheck());
}

boolean b2KeyCheck() {
  return (bKeyCheck() && dKeyCheck());
}

//triple note check
boolean c3KeyCheck() {
  return (cKeyCheck() && eKeyCheck() && gKeyCheck());
}

boolean d3KeyCheck() {
  return (dKeyCheck() && fKeyCheck() && aKeyCheck());
}

boolean e3KeyCheck() {
  return (eKeyCheck() && gKeyCheck() && bKeyCheck());
}

boolean f3KeyCheck() {
  return (fKeyCheck() && aKeyCheck() && cKeyCheck());
}

boolean g3KeyCheck() {
  return (gKeyCheck() && bKeyCheck() && dKeyCheck());
}

boolean a3KeyCheck() {
  return (aKeyCheck() && cKeyCheck() && eKeyCheck());
}

boolean b3KeyCheck() {
  return (bKeyCheck() && dKeyCheck() && fKeyCheck());
}

int pitchDetection() {
  if (c3KeyCheck()) {
    return 111;
  } else if (d3KeyCheck()) {
    return 112;
  } else if (e3KeyCheck()) {
    return 113;
  } else if (f3KeyCheck()) {
    return 114;
  } else if (g3KeyCheck()) {
    return 115;
  } else if (a3KeyCheck()) {
    return 116;
  } else if (b3KeyCheck()) {
    return 117;
  } else if (c2KeyCheck()) {
    return 11;
  } else if (d2KeyCheck()) {
    return 22;
  } else if (e2KeyCheck()) {
    return 33;
  } else if (f2KeyCheck()) {
    return 44;
  } else if (g2KeyCheck()) {
    return 55;
  } else if (a2KeyCheck()) {
    return 66;
  } else if (b2KeyCheck()) {
    return 77;
  } else if (cKeyCheck()) {
    return 1;
  } else if (dKeyCheck()) {
    return 2;
  } else if (eKeyCheck()) {
    return 3;
  } else if (fKeyCheck()) {
    return 4;
  } else if (gKeyCheck()) {
    return 5;
  } else if (aKeyCheck()) {
    return 6;
  } else if (bKeyCheck()) {
    return 7;
  } else {
    return 0;
  }
}


void stop()
{
  TG.Close();
  AS.Close();

  minim.stop();

  println("Se acabo");

  super.stop();
}
