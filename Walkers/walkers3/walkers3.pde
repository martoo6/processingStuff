
ArrayList<PVector> pList = new ArrayList<PVector>();
float round                = 100;
int cant                 =0;
PImage webImg;


void setup(){
  size(displayWidth, displayHeight);
  //size(200, 200);
  String url = "http://cdn01.wallconvert.com/_media/wallpapers_1920x1080/1/1/colorful-feathers-8511.jpg";
  webImg     =loadImage(url);
  background(0);
  fill(0,5);
  for(int i=0;i<100000;i++) pList.add(new PVector(random(width), random(height)));
}

void draw(){
  //background(0);
  noStroke();
  //rect(0,0,width,height);
  //if(cant == 500) {
    //cant=0;
    //round /= 2;
    //for(PVector p:pList) {p.set(random(width), random(height));}
    //println(round);
    //saveFrame("output/framesG####.png");
  //}
  //saveFrame("output/framesK####.png");
  cant++;
  //float count = frameCount*0.01;
  for (int i = 0; i<1; i++){
    for(PVector p:pList) {
      //float angle = noise(p.x*0.01,p.y*0.01, count)*round;
      float angle = (hue(webImg.get((int)p.x,(int)p.y))/255)*round;
      PVector f   = PVector.fromAngle(angle);
      f.mult(random(2));
      p.add(f);
      stroke(webImg.get((int)p.x,(int)p.y),50);
      point(p.x, p.y);
      //ellipse(p.x,p.y,5,5);
    }
  }
  
}

boolean sketchFullScreen() { 
  return true;
}
