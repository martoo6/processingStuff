import gifAnimation.*;
GifMaker gifExport;

Attractor[] atts = new Attractor[50];  
Particle[] pts = new Particle[500];

Boolean saved=false;

void setup() {
  size(400, 400);
  background(0);

  frameRate(30);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(255);

  for (int i=0;i<atts.length;i++) atts[i]=new Attractor();
  for (int i=0;i<pts.length;i++) pts[i]=new Particle();
}

void draw() {
  fill(0,50);
  rect(0,0,width,height);
  stroke(255);
  // background(0);
  //stroke(255);
  for (int i=0;i<pts.length;i++) {
    pts[i].update();
    pts[i].render();
  }
  for (int i=0;i<atts.length;i++) {
    //atts[i].update();
    //atts[i].render();
  }
  gifExport.setDelay(30);
  gifExport.addFrame();
}

void keyPressed(){
  if(!saved) gifExport.finish();
  saved=true;
  println("gif saved");
}

class Particle {
  PVector pos = new PVector(random(width), random(height));

  void render() {
    point(pos.x, pos.y);
  }

  void update() {
    PVector sum = new PVector(0, 0);
    for (int i=0;i<atts.length;i++) {
      PVector force = PVector.sub(atts[i].pos, pos);
      float dist = force.mag();
      force.normalize();
      force.mult(atts[i].strength*100/dist);
      sum.add(force);
    }
    pos.add(sum );
  }
}

class Attractor extends Particle {
  float strength = random(0.5, 1);

  void update() {
    PVector dir = PVector.fromAngle(noise(pos.x*0.01, pos.y*0.01, frameCount*0.001)*TWO_PI*10 );
    //dir.mult(5);
    pos.add(dir);
    if (pos.x>width) pos.x-=width;
    if (pos.y>height) pos.y-=height;
    if (pos.x<0) pos.x+=width;
    if (pos.y<0) pos.y+=height;
  }

  void render() {
    ellipse(pos.x, pos.y, 20, 20);
  }
}
