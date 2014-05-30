Vertes[][] vertexList;
int CANT=10;
float time=0;

void setup(){
  size(400,400, P3D);
  colorMode(HSB);
  background(0 );
  noStroke();
  vertexList = new Vertes[round(width/CANT)][round(height/CANT)];
  
  for(int i=0;i<CANT;i++) {
    for(int e=0;e<CANT;e++) {
      vertexList[e][i]=new Vertes(e*(width/CANT),i*(height/CANT));
    }
  } 
}

void draw(){
  time = abs(sin(frameCount * 0.1));
  background(0 );
  for(int i=0;i<CANT;i++) {
    for(int e=0;e<CANT;e++) {
      vertexList[e][i].update();
    }
  } 
  int triangle=0;
  for(int i=0;i<CANT-1;i++) {
    beginShape(TRIANGLE_STRIP);
    for(int e=0;e<CANT;e++) {
      PVector p1 = vertexList[e][i].pos;
      if(e%2==0) triangle++;
      fill(color(noise(time*0.1)*255,255,noise(triangle)*255));
      vertex(p1.x,p1.y);
      if(e%3==0) triangle++;
      fill(color(noise(time*0.1)*255,255,noise(triangle)*255));
      PVector p2 = vertexList[e][i+1].pos;
      //fill(vertexList[e][i+1].c);
      vertex(p2.x,p2.y);
    }
    endShape();  
  } 
  //if(time<2) saveFrame("v."+round(random(64265))+"-####.png");
}

class Vertes{
  PVector center;
  PVector pos;
  PVector destiny;
  color c;
  MotionStrategy mStrategy;
  
  Vertes(float e,float i){
    center = new PVector(e,i);
    pos = new PVector(e,i);
    reset();
  }
  
  void update(){
    PVector dir = PVector.sub(destiny,pos);
    float dist = PVector.dist(destiny,pos);
    if(dist<1) reset();
    dir.mult(0.1);
    pos.add(dir);
  }
  
  void reset(){
    PVector tmpVec = new PVector(random(width/CANT), random(height/CANT));
    destiny = PVector.add(center, tmpVec);
  }
}

interface MotionStrategy{
  void update(Vertes v);
}

class RandomPosStrategy{
  void update(Vertes v){
    
  }
}
