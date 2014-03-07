float t=0;
boolean record = false;
final float step = 20;
final float f = 0.003; //frequency
final float amp = 500;
final float cR = 0.002; //Change Rate between consecutive lines 

void setup() {
  size(800, 600);
  noStroke();
  smooth();
}

void draw() {
  float i=t;
  color c = color(255);
  while (i<height+500) {
    if(c == color(255)) c= color(200); else c= color(255);
    fill(c);
    strip(i);
    i+=step;
  }
  t+=3;//timeLike
  if(t>step*2) t-=step*2; 
  if(record) saveFrame();
  fill(0);
  text(frameRate,20, 20);
}

void strip(float i){
    beginShape();
    
    final float x_step = width/16.0f;
    
    curveVertex(0, i-noise(0, i*cR)*amp);
    for (float x=0;x<=width;x+=x_step) {
      curveVertex(x, i-noise(x*f, i*cR)*amp);
    }
    curveVertex(width, i-noise(width*f, i*cR)*amp);
    
    i+=step;
    vertex(width,i);
    
    curveVertex(width, i-noise(width*f, i*cR)*amp);
    for (float x=width;x>=0;x-=x_step) {
      curveVertex(x, i-noise(x*f, i*cR)*amp);
    }
    curveVertex(0, i-noise(0, i*cR)*amp);
    
    vertex(0,i-step);
    
    endShape();
}

void keyPressed(){
  if(key=='r' || key=='R') record=!record;
}
