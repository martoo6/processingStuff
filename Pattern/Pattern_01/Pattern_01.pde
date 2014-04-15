int Combinations[] = new int[]{-1,1};

int step=10;
int y=0;

void setup(){
  size(1280, 720);
  background(0);
  stroke(255);
  strokeWeight(2);
}

void draw(){ 
  for(int x=0;x<width;x+=step){
    line(Combinations[(int)random(2)]*step+x, y, Combinations[(int)random(1)]*step+x, y+step);
  }
  y+=step;
}
