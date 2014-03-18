ArrayList<element> elements = new ArrayList<element>();

void setup() {
  size(800, 600);
  background(0);
  for (int i=0;i<1000;i++) elements.add(new element());
  fill(255,10);
  noStroke();
}

void draw() {
  //background(0);
  fill(0,10);
  rect(0,0,width,height);
  fill(255);
  for (element e:elements) e.update();
  for (element e:elements) e.render();
}

class element {
  PVector pos=new PVector(random(width*0.49,width*0.51), random(height*0.49,height*0.51));
  float radius = 1;
  PVector defDir = PVector.fromAngle(random(TWO_PI*5));

  void update() {
    //PVector m = PVector.fromAngle(noise(pos.x*0.01, pos.y*0.01)*TWO_PI*5);
    //m.mult(0.1);
    pos.add(defDir);
    for (element e:elements) {
      if (e!=this) {
        if ((pos.dist(e.pos)-(e.radius+radius))<0) {
          //PVector dir=PVector.sub(e.pos,pos);
          //dir.normalize();
          //dir.mult(-2);
          //dir.mult(2);
          defDir.rotate(random(TWO_PI));
          //defDir.set(PVector.lerp(e.defDir,defDir,0.5));
          //e.defDir.set(defDir);
          //pos.add(dir);
        }
      }
    }
    if (pos.x<0) pos.x=width+pos.x;
    if (pos.y<0) pos.y=height+pos.y;
    if (pos.x>width) pos.x=width-pos.x;
    if (pos.y>height) pos.y=height-pos.y;
  }

  void render() {
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}
