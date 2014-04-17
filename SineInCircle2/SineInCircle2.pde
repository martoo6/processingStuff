final float step= (TWO_PI/4);  
final float maxRadius = 200;
int c = 0;

void setup() {
  size(500, 500);
  background(0);
  noFill();
  stroke(255);
}

void draw() {
  translate(width/2, height/2);
  background(0);
float f = sin(frameCount*0.01)*0.1;

  for (float i=0;i<TWO_PI;i+=step) {    
    beginShape();
    for (int e=10;e<500;e++) {
      float a=i+sin(e*f+frameCount*0.1)*PI*0.5;
      float x = cos(a)*e;
      float y = sin(a)*e;

      vertex(x, y);
    }
    endShape();
  }
  if(frameCount*0.01<TWO_PI){
    float f2 = pow(abs(f)*45,2);
    if(frameCount%round(f2+1)==0){
      c++;
      saveFrame(c+".png");
    }
  } 
}
