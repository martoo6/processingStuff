void setup(){
  size(800,800,P3D);
  background(0 );
  sphereDetail(10);
  colorMode(HSB );
}

void draw(){
  background(0 );
  pushMatrix();
  translate(width/2,height/2);
  rotateY(frameCount*0.01);
  rotateZ(frameCount*0.01);
  drawBlackSphere();
  drawSphere();
  popMatrix();
}

void drawBlackSphere(){
  noStroke();
  fill(0);
  sphere(150);
}

void drawSphere(){
  noFill();  
  int id=0;
  for(float omega=0;omega<TWO_PI;omega+=0.05){
    for(float delta=0;delta<PI;delta+=0.1){
      drawHair(omega, delta, id);
      id++;
    }
  }
}

void drawHair(float omega,float delta,float id){    
  final float maxDisplacement = 0.5;
  float x;
  float y;
  float z;
  
  int radius=150;
  PVector cord;
  
  beginShape();
  for(int i=0;i<10;i++){
    float displacement = noise(id,i*0.1 - frameCount*0.01)*maxDisplacement-maxDisplacement/2;
    cord = getSphereCoordinate(omega+displacement, delta, radius);
    stroke(100,255,map(i,0,5,0,255),60);
    vertex(cord.x,cord.y,cord.z);
    radius+=10;
    //delta+=noise(id, i*0.01 + frameCount*0.01)*0.1-0.5;
  }
  endShape();
}

PVector getSphereCoordinate(float omega,float delta, float radius){
  return new PVector(sin(omega)*cos(delta)*radius, sin(omega)*sin(delta)*radius,cos(omega)*radius);
}
