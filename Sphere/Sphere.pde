

void setup(){
  size(800,600, P3D);
  background(0 );
  blendMode(ADD);
  stroke(255,10);
  fill(255,200);
  sphereDetail(3);
}

void draw(){
  background(0);
  pushMatrix();
  
  translate(width/2, height/2);
  rotateX(frameCount*0.01);
  rotateY(frameCount*0.01);
  rotateZ(frameCount*0.01);
  for(float omega=0;omega<PI;omega+=noise(frameCount*0.01)*0.1+0.1){
    for(float delta=0;delta<TWO_PI;delta+=noise(frameCount*0.01+10)*0.1+0.1){
      float x= sin(omega)*cos(delta)*250;
      float y= sin(delta)*sin(omega)*250;
      float z= cos(omega)*250;
      line(0,0,0,x,y,z);
      pushMatrix();
      translate(x,y,z);
      sphere(2);
      popMatrix();
    }
  }
  popMatrix();
}
