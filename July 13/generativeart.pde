//Josh Mao 7/13/20 generative art

int planeX = 0;

//creating canvas size
void setup(){
  size(1000,650);
  smooth();
}

//initializing landscape and 3 planes animation
void draw(){
  landscape();
  if (planeX < (width + 12)){
    plane(planeX, 250);
    plane(planeX - 30, 300);
    plane(planeX + 30, 200);
    }
  else{
  planeX = 0;
  }
  planeX += 3;
}

//creating sunset landscape inspired by ramayac (https://www.openprocessing.org/sketch/68774)
void landscape(){
noStroke();
background(#FFCC48);
fill(#ffff00);
ellipse(width/2, (height/2) + 50, 400, 400);
fill(0);
arc(width/2, height, width*2, height/1.30, -PI, 0); 
}

//creating plane inspired by Chauvin (http://simpledesktops.com/browse/desktops/2012/sep/04/fly/)
void plane(int x, int y){
  ellipseMode(CENTER);
  float wingAngle = radians(45);
  pushMatrix();
    translate(x,y);
    ellipse(0, 0, 50, 5);
    pushMatrix();
      translate(-18, 0);
      rotate(wingAngle);
      ellipse(0, 0, 4, 18);
      popMatrix();
    pushMatrix();
      translate(8, 0);
      rotate(wingAngle);
      ellipse(0, 0, 9, 50);
      popMatrix();
  popMatrix();
}
