//Josh Mao 7/14/20 True Blue Game
//inspired by "Events" example during 7/13 lecture (https://github.com/michaelshiloh/CreativeProgrammingAndElectronicsBerkeley/blob/master/lectureNotes.md)

//setting up text messages and other global variables
String intro = "To win, click until you reach \n the true blue screen. \n *there may be color duplicates";
String win = "Congratulations!! You have won. \n Click to play again.";

final int colorChoices = 20;
color[] myColors = new color[colorChoices];
final color winningColor = color(0, 0, 255);


void setup(){
  size(700,700);
  background(#ffffff);
  
  //instructions
  PFont f = createFont("Arial", 30);
  textFont(f, 30);
  fill(0);
  textAlign(CENTER);
  text(intro, height/2, width/2.5);
  
  //setting color rotation
  myColors[0] = color(0,0,255);
  for (int i = 1; i < myColors.length; i ++ ){
      myColors[i]= color(random(255), random(255), random(250));
  }
}

//testing to see if player won
void draw(){
  color test = get(0, 20);
  if (test == winningColor){
  PFont f = createFont("Arial", 30);
  textFont(f, 30);
  fill(#ffffff);
  textAlign(CENTER);
  text(win, height/2, width/2);
  }
}

//making background change to a random color everytime it's pressed
void mousePressed(){
  int index =  int(random(myColors.length));
  background(myColors[index]);
}
