final int CONST_STEP=5;

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
  dir = dir1;
  for (int i=0;i<100;i++) walkers.add(new Walker());
}

void draw() {
  for (Walker w:walkers) w.render();
}

class Walker {
  PVector currentPos = new PVector(floor(random(width/CONST_STEP))*CONST_STEP, floor(random(height/CONST_STEP))*CONST_STEP);  

  public void render() {
    PVector currentDir = dir[(int)random(dir.length)];
    PVector nextPos = currentPos.get();
    nextPos.add(currentDir); 
    line(currentPos.x, currentPos.y, nextPos.x, nextPos.y);
    currentPos = nextPos;
    if (currentPos.x > width || currentPos.y > height || currentPos.x < 0 || currentPos.y < 0) currentPos = new PVector(floor(random(width/CONST_STEP))*CONST_STEP, floor(random(height/CONST_STEP))*CONST_STEP);
  }
}

