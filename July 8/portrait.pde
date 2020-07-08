//Josh Mao, Des Inv 23, 7/8/20

//set size and background color of portrait
size(300, 300);
background(#EBEBEB);

//drawing myself
noStroke();
fill(#89CFF0);
rect(90,150,20,45);
fill(#ffffff);
circle(100,150,20);

//drawing gf
fill(#F2BABA);
rect(190,150,20,45);
fill(#ffffff);
circle(200,150,20);

//drawing heart with shape from Illustrator
PShape heart = loadShape("Heart.svg");
fill(255,0,0);
shape(heart,137,154);
