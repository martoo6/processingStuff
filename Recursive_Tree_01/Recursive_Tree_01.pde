ArrayList<Branch> trees = new ArrayList<Branch>();

void setup(){
  size(1280,720);
  background(0);
  for(int i=0;i<10;i++) trees.add(new Branch(new PVector(random(width*0.25,width*0.75),height),1));
  stroke(255);
}

void draw(){
  background(0);
  for(Branch t:trees) t.render();
}

class Branch {
  static final int maxLevel = 6;
  PVector initPos;
  PVector endPos;
  ArrayList<Branch> subBranches = new ArrayList<Branch>();
  ArrayList<Flower> flowers = new ArrayList<Flower>();
  int level;
  
  Branch(PVector initPos, int level){
    this.level = level;
    this.initPos = initPos;
    this.endPos = new PVector(initPos.x+random(-250.0/level,250.0/level), initPos.y-random(100.0/level, 150.0/level));
    
    if(level<maxLevel) {
      float cant = random(1,level);
      for(int i=0;i<cant;i++) subBranches.add(new Branch(endPos, level+1));
    }else{
      float cant = random(4);
      for(int i=0;i<cant;i++) flowers.add(new Flower(PVector.lerp(initPos,endPos,random(0.8,1))));
    }
  }
  
  void render(){
    strokeWeight(20-level*3);
    stroke(255, 100);
    line(initPos.x, initPos.y, endPos.x, endPos.y);
    for(Branch b:subBranches) b.render();
    for(Flower f:flowers) f.render();
  }
}

class Flower{
  final color c = color(random(150,255), 10, 10);
  PVector pos;
  float radius = random(4,10);
  float petalCant = TWO_PI/random(5,12); 
  
  Flower(PVector pos){
    this.pos = pos;
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    fill(c);
    noStroke();
    for(float i=0;i<TWO_PI;i+=(petalCant)) ellipse(sin(i)*radius, cos(i)*radius, radius, radius);
    fill(255);
    ellipse(0,0,radius,radius);
    popMatrix();
  }
}

class Leaf{
  final color c = color(random(150,255), 10, 10);
  PVector pos;
  float radius = random(4,10);
  float petalCant = TWO_PI/random(5,12); 
  
  Leaf(PVector pos){
    this.pos = pos;
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    fill(c);
    noStroke();
    for(float i=0;i<TWO_PI;i+=(petalCant)) ellipse(sin(i)*radius, cos(i)*radius, radius, radius);
    fill(255);
    ellipse(0,0,radius,radius);
    popMatrix();
  }
}
