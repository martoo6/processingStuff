

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
  //rotateX(frameCount*0.01);
  rotateY(frameCount*0.01);
  //rotateZ(frameCount*0.01);
  for(float omega=-TWO_PI;omega<TWO_PI;omega+=0.4){
    for(float delta=-TWO_PI;delta<TWO_PI;delta+=0.4){
      float x1= sin(omega)*cos(delta)*250;
      float y1= sin(delta)*sin(omega)*250;
      float z1= cos(omega)*250;
      
      
      //Torus
      /*float x2= cos(omega)*(150+100*cos(delta));
      float y2= sin(omega)*(150+100*cos(delta));
      float z2= sin(delta)*100;*/
      
      //Cuerno de Gabriel
      /*float x2= 100/omega;
      float y2= 100/delta;
      float z2= 100/omega;*/
      
      //Cilinder
      /*float x2= sin(omega)*150;
      float y2= cos(omega)*150;
      float z2= delta*100-100;*/
      
      float osc = map(sin(frameCount*0.2),-1,1,1,5);
      
      x1= delta*10;
      y1= (omega+delta)*(omega+delta);
      z1= omega*10;
      
      float x2= delta*2*osc;
      float y2= pow((omega+delta),2)/osc;
      float z2= omega*10;
      
      float t=map(sin(frameCount*0.01),-1,1,0,1);
      
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
