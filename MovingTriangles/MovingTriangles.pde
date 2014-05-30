ArrayList<Vertes> vertexList = new ArrayList<Vertes>(); 
int CANT=10;

void setup(){
  size(400,400);
  for(int i=0;i<height;i+=height*2/CANT) {
    for(int e=0;e<=width;e+=width/CANT) {
      vertexList.add(new Vertes(e,i));
      vertexList.add(new Vertes(e,i+width/CANT));
    }
    for(int e=width;e>=0;e-=width/CANT) {
      vertexList.add(new Vertes(e,i+width*2/CANT));
    }
  } 
}

void draw(){
  background(0 );
  for(Vertes v:vertexList){
    v.update();
  } 
  beginShape(TRIANGLE_STRIP); 
  for(Vertes v:vertexList){
    vertex(v.pos.x, v.pos.y);
  }
  endShape();  
}

class Vertes{
  PVector center;
  PVector pos;
  PVector destiny;
  
  Vertes(float e,float i){
    center = new PVector(e,i);
    pos = new PVector(e,i);
    reset();
  }
  
  
  void update(){
    PVector dir = PVector.sub(destiny,pos);
    dir.mult(0.01);
    pos.add(dir);
    
  }
  
  void reset(){
    PVector tmpVec = PVector.random2D();
    tmpVec.mult(width/CANT);
    destiny = PVector.add(center, tmpVec);
  }
}
