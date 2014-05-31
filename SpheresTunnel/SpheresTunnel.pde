float depth=500;

void setup(){
  size(800,600, P3D);
  background(0);
}

void draw(){
  translate(width/2,height/2,0);
  background(0);
  lights();
  noStroke();
  for(float e=0;e<depth;e+=10){
    
    
    //color c = color(255);
    
    //for(float i=0;i<TWO_PI;i+=PI/60){
      float zPos =400 -(frameCount+e)*10 + (((frameCount+e)*10>depth)?depth:0);
      sphereDetail((int)map((int)zPos,0,-depth,20,1));
      color c = color(0,(int)(map(zPos,400,-depth,50,0)),(int)(map(zPos,400,-depth,200,0)));
      fill(c);
      
      for(float i=0;i<TWO_PI;i+=PI/15){
      PVector p = PVector.fromAngle(i+e*frameCount*0.0001);
      pushMatrix();
      //translate(p.x*200,p.y*200,400-e-noise(i*e)*25+sin((frameCount+e)*0.01)*100+200);
      translate(p.x*200,p.y*200,zPos);
      sphere(15+noise(e*(i+1))*50);
      popMatrix();
    }
  }
}
