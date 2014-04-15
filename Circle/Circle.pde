final int CANTLINES=30;

void setup(){
  size(800,600);
  background(0);
  stroke(255);
  noFill();
}

void draw(){
  translate(width/2, height/2);
  background(0);
  float start=PI/2;
  final float speed=0.01;
  final float amp = 80;
  for(int i=0;i<CANTLINES;i++){
    float left=start+(PI/CANTLINES)*i;
    float right=start-(PI/CANTLINES)*i;
    float y=sin(left)*200;
    float x = cos(left)*200;
    float xEnd = cos(right)*200;
    beginShape();
    curveVertex(x,y+noise((x+frameCount+i)*speed)*amp);
    for(float e=x;e<xEnd;e+=((xEnd-x)/10)){
      curveVertex(e,y+noise((e+frameCount+i)*speed)*amp);
    }
    curveVertex(xEnd,y+noise((xEnd+frameCount+i)*speed)*amp);
    curveVertex(xEnd,y+noise((xEnd+frameCount+i)*speed)*amp);
    endShape();
  }
}
