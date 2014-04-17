float r = 100; //Radius

void setup(){
  size(1280,720, P3D);
  background(0);
  stroke(255);
  noFill();
}

void draw(){
  background(0);
  translate(0,height/2);
  rotateX(frameCount*0.01);
  beginShape();
  for(float x=0;x<width;x++){
    //HELIX !!
    //float y= sin(x*0.1)*r;
    //float z= cos(x*0.1)*r;
    //AudioWave Alike
    //float y= sin(x*1.5)*r*noise(x*0.01, frameCount*0.1);
    //float z= sin(x*0.01)*r;
    //DNA Alike
    //float y= sin(x*10)*r;
    //float z= sin(x*10)*r*sin(x*0.01);
    float f=0.1*PI;
    float y= sin(x*f)*r;
    float z= cos(x*f)*r;
    curveVertex(x,y,z);
    
  }
  endShape();
}
