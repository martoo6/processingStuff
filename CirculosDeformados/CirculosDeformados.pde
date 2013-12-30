float step = 0.05;

void setup(){
  size(500,500);
  background(255);
  noFill();
  stroke(0);
  smooth();
}

void draw(){
  background(255);
  
  pushMatrix();
  translate(width/2, height/2);
  for(int e=0;e<50;e++){
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
}

float getVariation(float i, float e){
  return 100+noise(i*70, e*0.01,frameCount*0.01)*e*30;
}
