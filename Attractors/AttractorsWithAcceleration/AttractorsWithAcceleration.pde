import gifAnimation.*;
GifMaker gifExport;
int P_COUNT=5000;

Attractor[] atts = new Attractor[2];  
Particle[] pts = new Particle[P_COUNT];

//Force f = new nonRealisticForce();
Force f = new realisticForce();

int state=0;
Boolean showAttractors=false;
Boolean t=true; //Traces !

void setup() {
  size(1280, 720);
  background(0);

  gifExport = new GifMaker(this, "export.gif");
  gifExport.setRepeat(0); // make it an "endless" animation
  gifExport.setQuality(255);

  for (int i=0;i<atts.length;i++) atts[i]=new Attractor();
  for (int i=0;i<pts.length;i++) pts[i]=new Particle();
}

void draw() {
  if (t) {
    stroke(255, 20);
  }
  else {
    noStroke();
    fill(0, 100);
    rect(0, 0, width, height);
    stroke(255);
  }
  for (int i=0;i<pts.length;i++) {
    pts[i].update();
    pts[i].render();
  }
  if (showAttractors) {
    fill(0);
    for (int i=0;i<atts.length;i++) {
      //atts[i].update();
      atts[i].render();
    }
  }
  if (state==1) {
    gifExport.setDelay(30);
    gifExport.addFrame();
  }
}

void keyPressed() {
  if (key==ENTER) {
    state++;
    if (state==1) {
      println("Gif recording started");
    }
    if (state==2) {
      gifExport.finish();
      println("Gif saved");
    }
    if (state==3) {
      state=0;
      println("Press any key to record again");
    }
  }
  if (key=='s') showAttractors=!showAttractors;
  if (key=='t') {
    t=!t;
    background(0);
  }
  if (key=='1') f = new nonRealisticForce();
  if (key=='2') f = new realisticForce(); 
  if (key=='z') {
    if (P_COUNT/2==0) P_COUNT=2;
    pts = new Particle[P_COUNT/=2];
    for (int i=0;i<pts.length;i++) pts[i]=new Particle();
  }
  if (key=='x') {
    pts = new Particle[P_COUNT*=2];
    for (int i=0;i<pts.length;i++) pts[i]=new Particle();
  }
}

class Particle {
  PVector pos = new PVector(random(width), random(height));
  PVector vel = new PVector(0, 0);

  void reset() {
    pos.set(random(width), random(height));
    vel.set(0, 0);
  }

  void render() {
    point(pos.x, pos.y);
  }

  void update() {
    vel.add(f.calculate(this));
    vel.limit(8);
    pos.add(vel);
    //If the particles get to close to the attractor the will experiment a huge attraction and will "jump" offscreen, this re-position them 
    if (pos.x>width || pos.y>height || pos.x<0 || pos.y<0) reset();
  }
}

interface Force {
  PVector calculate(Particle p);
}

class nonRealisticForce implements Force {
  PVector calculate(Particle p) {
    PVector sum = new PVector(0, 0);
    for (int i=0;i<atts.length;i++) {
      PVector force = PVector.sub(atts[i].pos, p.pos);
      float dist = force.mag();
      //It's like a collision with the attractor
      if (dist<5) {
        p.reset();
        return new PVector(0, 0);
      }
      force.normalize();
      force.mult(atts[i].strength*10/dist);
      sum.add(force);
    }
    return sum;
  }
}

class realisticForce implements Force {
  PVector calculate(Particle p) {
    PVector sum = new PVector(0, 0);
    for (int i=0;i<atts.length;i++) {
      PVector force = PVector.sub(atts[i].pos, p.pos);
      float dist = force.mag();
      //It's like a collision with the attractor
      if (dist<5) {
        p.reset();
        return new PVector(0, 0);
      }
      force.normalize();
      force.mult(atts[i].strength*100/(dist*dist)); //More realistic, just like newtons gravtity ecuation
      sum.add(force);
    }
    return sum;
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
