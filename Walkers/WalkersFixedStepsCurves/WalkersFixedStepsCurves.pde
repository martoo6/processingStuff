final int CONST_STEP=1;

PVector[] dir;

PVector[] dir1 = new PVector[] {
  new PVector(0, CONST_STEP), 
  new PVector(0, -CONST_STEP), 
  new PVector(CONST_STEP, 0), 
  new PVector(-CONST_STEP, 0),
  new PVector(CONST_STEP, CONST_STEP), 
  new PVector(CONST_STEP, -CONST_STEP), 
  new PVector(-CONST_STEP, CONST_STEP), 
  new PVector(-CONST_STEP, -CONST_STEP)
  };
PVector[] dir2 = new PVector[] {
  new PVector(CONST_STEP, CONST_STEP), 
  new PVector(CONST_STEP, -CONST_STEP), 
  new PVector(-CONST_STEP, CONST_STEP), 
  new PVector(-CONST_STEP, -CONST_STEP)
  };
PVector[] dir3 = new PVector[] {
  new PVector(0, CONST_STEP), 
  new PVector(0, -CONST_STEP), 
  new PVector(CONST_STEP, 0), 
  new PVector(-CONST_STEP, 0)
  };
    
  ArrayList<Walker> walkers= new ArrayList<Walker>(); 

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  stroke(255);
  dir = dir3;
  for (int i=0;i<100;i++) walkers.add(new Walker());
}

void draw() {
  for (Walker w:walkers) {
    w.update();
    w.render();
  }
}

class Walker {  
  ArrayList<PVector> allPos = new ArrayList<PVector>();
  
  public Walker(){
    PVector tmpVec1 = new PVector(floor(random(width/CONST_STEP))*CONST_STEP, floor(random(height/CONST_STEP))*CONST_STEP);
    PVector tmpVec2 = PVector.add(tmpVec1,dir[(int)random(dir.length)]);
    PVector tmpVec3 = PVector.add(tmpVec2,dir[(int)random(dir.length)]);
    PVector tmpVec4 = PVector.add(tmpVec3,dir[(int)random(dir.length)]);
    allPos.add(tmpVec1);
    allPos.add(tmpVec2);
    allPos.add(tmpVec3);
    allPos.add(tmpVec4);
  }
  
  public void update(){
     PVector tmpVec = PVector.add(allPos.get(3),PVector.mult(dir[(int)random(dir.length)], random(5,20)));
     //PVector tmpVec = PVector.add(allPos.get(3),new PVector(random(-15,15),random(-15,15)));
     allPos.remove(0);
     allPos.add(tmpVec);
  }
  
  public void render() {
    curve(allPos.get(0).x, allPos.get(0).y, allPos.get(1).x, allPos.get(1).y, allPos.get(2).x, allPos.get(2).y, allPos.get(3).x, allPos.get(3).y);
    //if (currentPos.x > width || currentPos.y > height || currentPos.x < 0 || currentPos.y < 0) currentPos = new PVector(floor(random(width/CONST_STEP))*CONST_STEP, floor(random(height/CONST_STEP))*CONST_STEP);
  }
}

