ArrayList<PVector> pList = new ArrayList<PVector>();
int round = 100;
int cant=0;

void setup(){
  size(displayWidth, displayHeight);
  //size(200, 200);
  background(0);
  fill(0,5);
  for(int i=0;i<10;i++) pList.add(new PVector(random(width), random(height)));
}

void draw(){
  //background(0);
  noStroke();
  rect(0,0,width,height);
  //if(cant == 500) {
    //cant=0;
    //round /= 2;
    //for(PVector p:pList) {p.set(random(width), random(height));}
    //println(round);
    //saveFrame("output/framesG####.png");
  //}
  //saveFrame("output/framesK####.png");
  cant++;
  for(PVector p:pList) {
    float angle = noise(p.x*0.01,p.y*0.01)*round;
    PVector f = PVector.fromAngle(angle);
    f.mult(random(5,45));
    PVector p2 = p.get();
    p2.add(f);
    stroke(0, 255-(angle/round)*255, (angle/round)*255);
    line(p.x,p.y,p2.x,p2.y);
    p.set(p2.x,p2.y);
  }
  
}

boolean sketchFullScreen() { 
  return true;
}
