float r = 100; //Radius
PGraphics g;


void setup(){
  size(1280,720, P3D);
  background(0);
  g = createGraphics(width, height,P3D);
}

void draw(){
  background(0);

  getDna(1,255);
  image(g,0,0);
}

void getDna(float h, int opacity){
  
  
  float f=0.01;
  g.beginDraw();
  g.clear();
  
  g.stroke(255,opacity);
  g.strokeWeight(h);
  g.noFill();
  
  g.translate(0,height/2);
  g.rotateX(frameCount*0.01);
  
  g.beginShape();
  for(float x=0;x<width;x++){
    float y= sin(x*f)*r;
    float z= cos(x*f)*r;
    g.curveVertex(x,y,z);
  }
  g.endShape();
  //Second helix which phase + PI
  g.beginShape();
  for(float x=0;x<width;x++){
    float y= sin(x*f+PI)*r;
    float z= cos(x*f+PI)*r;
    g.curveVertex(x,y,z);
  }
  g.endShape();
  for(float x=0;x<width;x+=TWO_PI*2){
      float y= sin(x*f)*r;
      float z= cos(x*f)*r;
      float y2= sin(x*f+PI)*r;
      float z2= cos(x*f+PI)*r;
      g.line(x,y,z,x,y2,z2);
  }
  
  g.endDraw();
}
