void setup(){
  size(400,400, P3D);
  background(0 );
  blendMode(ADD);
  noStroke();
  sphereDetail(6);
}

void draw(){
  background(0);
  pushMatrix();
  
  translate(width/2+cos(frameCount*(PI/100))*150, height/2 ,sin(frameCount*(PI/100))*250-100);
  rotateY(-frameCount*(PI/100));
  for(float omega=-TWO_PI;omega<TWO_PI;omega+=0.5){
    for(float delta=-TWO_PI;delta<TWO_PI;delta+=0.5){
      
      float osc = map(sin(frameCount*0.2),-1,1,4,10);
      
      float x= delta*osc;
      float y= pow((omega+delta),2)/osc;
      float z= omega*10;
      
      fill(abs(x),0,abs(z));
      
      pushMatrix();
      translate(x,y,z);
      sphere(2);
      popMatrix();
    }
  }
  popMatrix();
  if(frameCount<200) saveFrame("A####.tif");
}
