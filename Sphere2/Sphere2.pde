void setup(){
  size(400,400,P3D);
  background(0 );
  sphereDetail(5);
}

void draw(){
  background(0 );
  pushMatrix();
  translate(width/2,height/2);
  rotateY(frameCount*0.01);
  drawBlackSphere();
  drawSphere();
  popMatrix();
  if(frameCount*0.01<TWO_PI && frameCount%4==0) saveFrame("####.png" );
}

void drawBlackSphere(){
  sphereDetail(5);
  stroke(255,60);
  fill(0);
  sphere(100);
}

void drawSphere(){
  noFill();  
  stroke(255,30);
  int id=0;
  sphereDetail(2);
  for(float omega=0;omega<TWO_PI;omega+=0.15){
    for(float delta=0;delta<PI;delta+=0.15){
      drawHair(omega, delta, id);
      id++;
    }
  }
}

void drawHair(float omega,float delta,float id){    
  float x;
  float y;
  float z;
  
  int radius=150;
  PVector cord;
    cord = getSphereCoordinate(omega, delta, radius);
    pushMatrix();
    translate(cord.x,cord.y,cord.z);
    sphere(5);
    popMatrix();
}

PVector getSphereCoordinate(float omega,float delta, float radius){
  return new PVector(sin(omega)*cos(delta)*radius, sin(omega)*sin(delta)*radius,cos(omega)*radius);
}
