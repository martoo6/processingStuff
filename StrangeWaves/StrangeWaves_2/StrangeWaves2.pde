int t=0;
boolean record = false;
int step = 5;

void setup() {
  size(800, 600, P2D);
  background(0);
  noStroke();
  smooth();
}

void draw() {
  background(0);
  int i=0;
  while (i<height+500) {
    fill(sin(i*0.1-t*0.5)>0 ? color(255): color(200));
    beginShape();
    
    curveVertex(0, i-noise(0, i*0.003)*500);
    for (float x=0;x<=width;x+=width/8.0f) {
      curveVertex(x, i-noise(x*0.005, i*0.003)*500);
    }
    curveVertex(width, i-noise(width*0.005, i*0.003)*500);
    
    i+=step;
    vertex(width,i);
    
    curveVertex(width, i-noise(width*0.005, i*0.003)*500);
    for (float x=width;x>=0;x-=width/8.0f) {
      curveVertex(x, i-noise(x*0.005, i*0.003)*500);
    }
    curveVertex(0, i-noise(0, i*0.003)*500);
    
    vertex(0,i-step);
    
    endShape();
  }
  t++;//timeLike
  if(record) saveFrame();
}

void keyPressed(){
  if(key=='r' || key=='R') record=!record;
}
