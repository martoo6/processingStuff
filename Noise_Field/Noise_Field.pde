void setup(){
  size(400,400);
  background(0);
  smooth();
  noFill();
  stroke(255);
}

void draw(){
  background(0);
  for(int x=0;x<width;x+=10){
    for(int y=0;y<height;y+=10){
      line(x,y, x+cos(noise(x,y, (mouseX + mouseY)*0.01)*TWO_PI)*5, y+sin(noise(x,y, (mouseX + mouseY)*0.01)*TWO_PI)*5);
    }
  }
}
