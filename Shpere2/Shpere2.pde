

void setup(){
  size(800,600, P3D);
  background(0 );
  blendMode(ADD);
  fill(255,200);
  sphereDetail(5);
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
      float x1= sin(omega)*cos(delta)*250;
      float y1= sin(delta)*sin(omega)*250;
      float z1= cos(omega)*250;
      
      float x2= cos(delta)*150;
      float y2= sin(delta)*150;
      float z2= cos(delta)*150;
      
      float t=abs(sin(frameCount*0.01));
      
      float x = lerp(x1,x2,t);
      float y = lerp(y1,y2,t);
      float z = lerp(z1,z2,t);
      
      pushMatrix();
      translate(x,y,z);
      sphere(2);
      popMatrix();
    }
  }
  popMatrix();
}
