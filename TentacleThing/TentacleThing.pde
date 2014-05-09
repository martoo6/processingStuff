import peasy.*;

PeasyCam cam;

int cant = 50;
float large =1;
float rateChange=0.01;
int distPoints=5;
Boolean b=false;
Boolean sf=true;

void setup(){
  size(400,400, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
  background(0 );
  noFill();
}

void draw(){
  large+=0.5;
  if(b) background(0 );
  for(int i=0;i<cant;i++){
    float x, y, z;
    x = noise(i,0)-0.5;
    y = noise(i,8)-0.5;
    z = noise(i,33)-0.5;
    PVector dir = new PVector(x,y,z);
    dir.mult(distPoints);
    beginShape();
    //curveVertex(0,0,0);
    //curveVertex(0,0,0);
    vertex(0,0,0);
    for(int e=0;e<large;e++){
      //stroke(noise(e*0.01)*255,255,255, b?180:10);
      stroke(i*5,255,255, b?180:10);
      vertex(dir.x,dir.y,dir.z);
      float xT, yT, zT;
      xT = noise(i,e*rateChange,frameCount*0.001)-0.5;
      yT = noise(i+33,e*rateChange,frameCount*0.001)-0.5;
      zT = noise(i+8,e*rateChange,frameCount*0.001)-0.5;
      //if(i==0){
      //  println(xT, yT, zT);
      //}
      PVector tmp = new PVector(xT, yT, zT);
      tmp.mult(distPoints);
      dir.add(tmp);
    }
    endShape();
  }
  if(sf && frameCount%2==0) saveFrame("####.png");
}

void keyPressed(){
  if(key=='b'||key=='B') b=!b;
  if(key=='s'||key=='S') sf=!sf;
}
