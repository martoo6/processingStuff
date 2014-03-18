//final float step= (TWO_PI/10); 
final float maxRadius = 200;


void setup(){
  background(0);
  noFill();
  size(600,600);
  stroke(255);
  noLoop();
}

void draw(){
  translate(width/2,height/2);
  //background(0);
  beginShape();
//  curveVertex(cos(TWO_PI-step)*maxRadius*noise(TWO_PI-step),sin(TWO_PI-step)*maxRadius *noise(TWO_PI-step));
//  for(float i=0;i<TWO_PI;i+=step){
//    curveVertex(cos(i)*maxRadius*noise(i),sin(i)*maxRadius *noise(i));
//  }
//  curveVertex(cos(0)*maxRadius*noise(0),sin(0)*maxRadius *noise(0));
//  curveVertex(cos(step)*maxRadius*noise(step),sin(step)*maxRadius *noise(step));
  
  float[] r= new float[100];
  for(int i=0;i<r.length;i++) r[i]=random(0.9,1);
  final float step= (TWO_PI/r.length); 
  
  curveVertex(cos(TWO_PI-step)*maxRadius*r[r.length-1],sin(TWO_PI-step)*maxRadius *r[r.length-1]);
  for(int i=0;i<r.length;i++){
    curveVertex(cos(step*i)*maxRadius*r[i],sin(step*i)*maxRadius *r[i]);
  }
  curveVertex(cos(0)*maxRadius*r[0],sin(0)*maxRadius*r[0]);
  curveVertex(cos(step)*maxRadius*r[1],sin(step)*maxRadius *r[1]);
  endShape();
  
}

void keyPressed( ){
  noiseSeed((long)random(10000));
  println(noise(0));
  redraw();
}
