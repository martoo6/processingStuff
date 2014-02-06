ArrayList<Walker> walkers = new ArrayList<Walker>(); //<>//

void setup() {
  size(1280, 720);
  for (int i=0;i<100;i++) {
    walkers.add(new Walker());
  }
  //stroke(255, 10);
  noStroke();
  background(0);
}


void draw() {
  //background(0);
  for (Walker w:walkers) {
    w.update();
    w.render();
  } 
}

public class Walker {
  final float curvature = TWO_PI*5;
  PVector pos=new PVector(random(width), random(height));
  float angle=getAngle(pos);
  final color c = color(random(255), 10);

  float getAngle(PVector pos) {
    return noise(pos.x*0.001, pos.y*0.001, frameCount*0.01)*TWO_PI*3;
  }

  void update() {
    angle = getAngle(pos);
    final PVector dir = PVector.fromAngle(angle);
    dir.mult(3);
    pos.add(dir);
    if (pos.x>width || pos.y>height || pos.x <0|| pos.y<0) {
      pos = new PVector(random(width), random(height));
      angle = getAngle(pos);
    }
  }

  void render() {
    //stroke(c);
    fill(c);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    //line(0, 0, 50, 0);
    //triangle(0,0,-25,-50,25,-50);
    triangle(-25,0,25,0,0,-50);
    popMatrix();
  }
}
