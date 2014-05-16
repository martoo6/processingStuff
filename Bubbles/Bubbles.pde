int CANT=100;
ArrayList<Bubble> bList = new ArrayList<Bubble>(); 

void setup(){
  size(400,400, P3D);
  background(0);
  sphereDetail(10);
  fill(255);
  noStroke();
  for(int i=0;i<CANT;i++) bList.add(new Bubble());
}

void draw(){
  background(0);
  lights();
  for(int i=bList.size()-1;i>=0;i--) bList.get(i).update();
  for(Bubble b:bList) b.render();
}

class Bubble{
  PVector pos = new PVector(random(width), random(height), random(-300,-50));
  float size=15;
  
  void update(){
    for(int i=bList.size()-1;i>=0;i--) {
      Bubble item = bList.get(i);
      if(item!=this && pos.dist(item.pos)<=size+item.size){
        bList.remove(this);
        item.size+=size*0.2;
        return;
      }
    } 
    pos.add(noise(pos.x*0.01, frameCount*0.01)*2-1,noise(pos.y*0.01, frameCount*0.01)*2-1,noise(pos.z*0.01, frameCount*0.01)*2-1);
  }
  
  void render(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    sphere(size);
    popMatrix();
  }
}
