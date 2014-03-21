float e=0;
void setup(){
  size(800,600);
  noFill();
  stroke(255);
}

void draw(){
  e+=0.5;
  if(e==height+100) e=0;
  //background(0);
  stroke(noise(frameCount*0.01)*255, noise(frameCount*0.01+64)*255, noise(frameCount*0.01+128)*255);
  translate(0,e);
  beginShape();
//Noise for frequency and phase
curveVertex(0,f(0));
for(int x=0;x<width;x++){
  vertex(x,f(x)*100);
}
curveVertex(0,f(width));
endShape();
}

float f(float x){
  return sin(0.1*x*noise(frameCount*0.001)+noise(frameCount*0.00001+10)*TWO_PI*100);
}
