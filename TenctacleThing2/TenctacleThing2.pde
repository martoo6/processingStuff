import peasy.*;

PeasyCam cam;

int cant = 500;
float large =10;
float rateChange=0.1;
int distPoints=5;
Boolean b=true;

void setup(){
  size(500,500, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
  background(0 );
  noFill();
  strokeWeight(2);
}

void draw(){
  if(b) background(0 );
  for(int i=0;i<cant;i++){
    float x, y, z;
    x = noise(i,0)-0.5;
    y = noise(i,8);
    z = noise(i,33)-0.5;
    PVector dir = new PVector(x,y,z);
    dir.mult(distPoints);
    beginShape();
    //curveVertex(0,0,0);
    //curveVertex(0,0,0);
    vertex(0,0,0);
    for(int e=0;e<large;e++){
      //stroke(noise(e*0.01)*255,255,255, b?180:10);
      stroke((255.0/cant)*i,255,255, b?180:10);
      vertex(dir.x,dir.y,dir.z);
      float xT, yT, zT;
      xT = noise(i,e*rateChange,frameCount*0.001)-0.5;
      yT = noise(i+33,e*rateChange,frameCount*0.001);
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
}

void keyPressed(){
  if(key=='b'||key=='B') b=!b;
}
