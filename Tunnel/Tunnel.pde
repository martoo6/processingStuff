void setup(){
  size(300,300, P3D);
  background(0);
  noFill();
}

void draw(){
  translate(width/2,height/2);
  background(0);
  for(float i=0;i<300;i+=0.5){
    if(abs(i-frameCount)%50<25){
      stroke(100,100,255);
    }else {
      stroke(100,255,255);
    }
    noiseSeed(1);
    float x = noise((i-frameCount)*0.01)*100-50;
    noiseSeed(0);
    float y = noise((i-frameCount)*0.01)*100-50;
    pushMatrix();
    translate(x,y,i);
    float s = map(i,400,0,200,50);
    ellipse(0,0,s,s);
    popMatrix();
  }
}
