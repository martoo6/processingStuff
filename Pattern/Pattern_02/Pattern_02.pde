int step=20;
int y=0;

void setup(){
  size(1280, 720);
  background(0);
  stroke(255,100);
  strokeWeight(8);
}

void draw(){ 
  for(int x=0;x<width;x+=step){
    line(x, y, round(random(-1,1))*step+x, y+step);
  }
  y+=step;
}
