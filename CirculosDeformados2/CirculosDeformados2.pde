float step = 0.05;

void setup(){
  size(400,400);
  colorMode(HSB );
  background(255);
  noFill();
  noStroke();
  smooth();
}

void draw(){
  background(255);
  
  pushMatrix();
  translate(width/2, height/2);
  for(int e=50;e>0;e--){
    float c = map(e,0,50,0,255);
    fill((int)c,255,255, 200);
    beginShape();
    for(float i=-step;i<=TWO_PI;i+=step){
      curveVertex(cos(i)*getVariation(i, e),sin(i)*getVariation(i, e));
      //ellipse(cos(i)*getVariation(i, e),sin(i)*getVariation(i, e), 10, 10);
    }
    curveVertex(cos(0)*getVariation(0, e),sin(0)*getVariation(0, e));
    curveVertex(cos(step)*getVariation(step, e),sin(step)*getVariation(step, e));
    endShape();
  }
  popMatrix();
  
  if(frameCount*0.1<TWO_PI) saveFrame("A######.png");
}

float getVariation(float i, float e){
  return pow(sin(frameCount*0.1),2)*100+noise(i*70, e*0.01,sin(frameCount*0.01)*1)*e*30;
}
