void setup(){
  size(400,400,P3D);
  background(0 );
  sphereDetail(15);
  strokeWeight(5);
  strokeCap(ROUND);
  strokeJoin(ROUND);
  colorMode(HSB );
}

void draw(){
  background(0 );
  lights();
  pushMatrix();
  translate(width/2,height/2);
  rotateY(frameCount*0.01);
  rotateZ(frameCount*0.01);
  drawBlackSphere();
  drawSphere();
  popMatrix();
  //if(frameCount<200) saveFrame("####.tif");
}

void drawBlackSphere(){
  noStroke();
  fill(0);
  sphere(50);
}

void drawSphere(){
  noFill();  
  strokeCap(ROUND);
  strokeJoin(ROUND);
  int id=0;
  for(int i=0;i<1500;i++){
      drawHair(i/100, i, id);
      id++;
  }
}

void drawHair(float omega,float delta,float id){    
  final float maxDisplacement = 0.5;
  float x;
  float y;
  float z;
  
  int radius=50;
  PVector cord;
  
  int max = int(noise(id)*10);
  beginShape();
  for(int i=0;i<max;i++){
    float displacement = noise(id,i*0.1 - frameCount*0.01)*maxDisplacement-maxDisplacement/2;
    cord = getSphereCoordinate(omega+displacement, delta, radius);
    stroke(noise(frameCount*0.01)*100,255,map(i,0,max,0,255),60);
    vertex(cord.x,cord.y,cord.z);
    radius+=10;
    //delta+=noise(id, i*0.01 + frameCount*0.01)*0.1-0.5;
  }
  endShape();
}

PVector getSphereCoordinate(float omega,float delta, float radius){
  return new PVector(sin(omega)*cos(delta)*radius, sin(omega)*sin(delta)*radius,cos(omega)*radius);
}
