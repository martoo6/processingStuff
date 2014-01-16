final int step = 10;

ArrayList<Walker> walkers= new ArrayList<Walker>(); 

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  stroke(255,10);
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

  public Walker() {
    reset();
  }

  void reset() {
    allPos.clear();
    PVector tmpVec = new PVector(random(width), random(height));
    for(int i=0;i<4;i++) allPos.add(tmpVec);
  }

  public void update() {
    PVector lastPos = allPos.get(3);
    PVector tmpVec = PVector.add(lastPos, PVector.mult(PVector.fromAngle(noise(lastPos.x*0.001, lastPos.y*0.001, frameCount*0.01)*TWO_PI*20), step));
    allPos.remove(0);
    allPos.add(tmpVec);
    if (allPos.get(3).x > width || allPos.get(3).y > height || allPos.get(3).x < 0 || allPos.get(3).y < 0) reset();
  }

  public void render() {
    curve(allPos.get(0).x, allPos.get(0).y, allPos.get(1).x, allPos.get(1).y, allPos.get(2).x, allPos.get(2).y, allPos.get(3).x, allPos.get(3).y);
  }
}

