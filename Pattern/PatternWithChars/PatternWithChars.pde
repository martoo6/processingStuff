int step=10;
int y=0;
String[] strings = new String[]{"\\", "/"}; 

void setup(){
  size(1280, 720);
  background(0);
  fill(255);
}

void draw(){ 
  for(int x=0;x<width;x+=step){
    text(strings[round(random(strings.length-1))],x+step, y+step);
  }
  y+=step;
}
