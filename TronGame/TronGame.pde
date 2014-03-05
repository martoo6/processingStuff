ArrayList<Walker> walkers = new ArrayList<Walker>();
int time=0;
float speed = 0.1; 
int amoutOfWalkers=2;
final color black = color(0);
PVector grid[][];


PGraphics traces;

void setup() {
  frameRate(20);
  size(1280, 720);
  background(0);
  for (int i=0;i<amoutOfWalkers;i++) walkers.add(new Walker(i));
  stroke(255);
  smooth(32);
  traces = createGraphics(width, height);
  grid = new PVector[width][height];
}

void draw() {
  background(0);
  if (keyPressed) {
    final float step = PI/32;
    Walker w;

    w=walkers.get(0);
    if (key=='a') w.currentAngle-=step;
    if (key=='d') w.currentAngle+=step;

    if (key=='w') w.speed+=0.1;
    if (key=='s') w.speed-=0.1;

    if (key=='q') w.speed-=0.1;

    if (key==LEFT) walkers.get(1).currentAngle-=step;
    if (key==RIGHT) walkers.get(1).currentAngle+=step;

    if (w.speed>10) w.speed = 10;
    if (w.speed<0.2) w.speed = 0.5;
  }
  for (int i=0;i<10*speed;i++) {
    for (Walker w:walkers) w.update(time);
    traces.beginDraw();
    traces.background(color(0));
    for (Walker w:walkers) w.render();
    traces.endDraw();
    time++;
  }
  set(0, 0, traces);
  text(frameRate, 20, 20);
  int e=width-50;
  for (Walker w:walkers) {
    fill(w.myColor, 255);
    text(w.lifes, e, 20);
    e-=50;
  }
}

class Walker {
  ArrayList<PVector> lastPos = new ArrayList<PVector>();
  int initSeed;
  color myColor;
  float currentAngle=0;
  float speed=5;
  int lifes=5;

  Walker(int initSeed) {
    this.initSeed = initSeed;
    myColor = color((int)random(255), (int)random(255), 255);
    restart();
  }

  void update(int time) {
    lastPos.remove(0);

    PVector dir = PVector.fromAngle(currentAngle);
    dir.mult(speed);
    PVector currentPos = PVector.add(dir, lastPos.get(lastPos.size()-1));
    lastPos.add(currentPos);

    float x1 = currentPos.x;
    float y1 = currentPos.y;
    if (x1<0 || y1 <0 || x1>width || y1> height) {
      restart();
      return;
    }



    for (Walker w:walkers) {
      int checkLength = (w==this )? w.lastPos.size()-1: w.lastPos.size();
      for (int i=1;i<checkLength;i++) {
        if (colision(lastPos.get(lastPos.size()-1), lastPos.get(lastPos.size()-2), w.lastPos.get(i), w.lastPos.get(i-1))) {
          restart();
          return;
        }
      }
    }
  }

  void restart() {
    PVector currentPos = new PVector(random(width), random(height));
    lastPos.clear();
    for (int i=0;i<200;i++) lastPos.add(currentPos.get());
    update(time);
    lifes--;
  }

  void render() {
    float step=255/lastPos.size();
    int brightness=0;
    for (int i=1;i<lastPos.size();i++) {
      traces.stroke(myColor, brightness);
      traces.line(lastPos.get(i-1).x, lastPos.get(i-1).y, lastPos.get(i).x, lastPos.get(i).y);
      brightness+=step;
    } 
  }
}



boolean colision(PVector p1, PVector p2, PVector p3, PVector p4) {
  float x1 = p1.x;
  float x2 = p2.x;
  float x3 = p3.x;
  float x4 = p4.x;

  float y1 = p1.y;
  float y2 = p2.y;
  float y3 = p3.y;
  float y4 = p4.y;

  float a = (y2-y1)/(x2-x1);
  float c = (y4-y3)/(x4-x3);
  final float b = y1-a*x1;
  final float d = y3-c*x3;
  
  //Different slope means they might intersect, im not checking overlaping rects
  if (c!=a) {

    
    final float min = max(min(x1, x2), min(x3, x4));
    final float max = min(max(x1, x2), max(x3, x4)); 

    float xIntersec = (d-b)/(a-c);

    if(xIntersec>min && xIntersec<max){//if i use >= / <= i will always get a colision with my last one
      println(xIntersec, min, max);
      return true;    
    }
  }else{
    if(b==d && ((x1<max(x3,x4) && x1>min(x3,x4) )|| (x2<max(x3,x4) && x2>min(x3,x4) ) )) return true;
  }
  return false;
}
