PImage img;

void setup(){
  img = loadImage("./spaceman.png");
  size(img.width,img.height);
  background(0 );
  image(img,0,0);
}

void draw(){
  image(img,0,0);  
}
