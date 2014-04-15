void setup(){
  size(800,600);
  fill(255,10);
  noStroke();
  background(0 );
  stroke(0,10);
}

void draw(){
  fill(0,5);
  rect(0,0,width,height);
  fill(255,10);
  stroke(0,10);
  translate(width/2,height/2);
  for(int i=0;i<10;i++) drawCircle(i*0.1);
}

void drawCircle(float seed){
  beginShape();
  float s = noise(0, seed, frameCount*0.01)*(height/2);
  curveVertex(cos(0)*s,sin(0)*s);
  float step=TWO_PI/50;
  for(float i=0;i<TWO_PI;i+=step){
    s = noise(i*10, seed, frameCount*0.01)*(height/2);
    curveVertex(cos(i)*s,sin(i)*s);
  }
  s = noise(0, seed, frameCount*0.01)*(height/2);
  curveVertex(cos(0)*s,sin(0)*s);
  curveVertex(cos(0)*s,sin(0)*s);
  endShape();
}
