int t=0;
boolean record = false;

void setup() {
  size(800, 600);
  background(0);
  stroke(255 );
  noFill();
  smooth();
  strokeWeight(8);
}

void draw() {
  background(0);
  int i=0;
  while (i<height+500) {
    stroke(sin(i*0.1-t*0.5)>0 ? color(255): color(200));
    beginShape();
    for (int x=-100;x<width+200;x+=width/8) {
      curveVertex(x, -noise(x*0.005, i*0.003)*500+i);
    }
    endShape();
    i++;
  }
  t++;//timeLike
  if(record) saveFrame();
}

void keyPressed(){
  if(key=='r' || key=='R') record=!record;
}
