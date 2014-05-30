float[][] noiseMap;
ArrayList<Brush> brushes;
PImage imgMap;
int num = 500, min=2, max=50;
float noiseIncr = .01, drain=.05, brushSize;

void setup() {
  //imgMap = loadImage("http://everythingforpeople.files.wordpress.com/2011/11/7098-natalie-portman-black-and-white-earrings-closeup-face.jpg");
  //imgMap.resize(round(imgMap.width*0.5),round(imgMap.height*0.5));
  
  //imgMap = loadImage("http://lloydi.com/travel-writing/portugal/algarve/images/day9/owl-close-up.jpg");
  //imgMap = loadImage("http://www.walldesk.net/pdp/1024/03/08/Cat-Close-up.jpg");
  
  //imgMap = loadImage("http://www.inspirefirst.com/wp-content/uploads/2011/04/cu1a.jpg");
 imgMap = loadImage("http://www.linkdelight.com/images/stories/articles/landscape_photography_tips.jpg");
  size(imgMap.width, imgMap.height);
  noStroke();
  brushes = new ArrayList<Brush>();
}

void draw() {
  brushSize = constrain(map(frameCount, 0, 1500, max, min), min, max);
  while (brushes.size()<num) brushes.add(new Brush(new PVector(random(width), random(height))));  
  for (Brush brush: brushes) {
    brush.update();
    brush.display();
  }
  if(brushSize==min){
    save("lostsofCurls"+random(2334234)+".png");
    exit();
  }
}

void keyPressed() {
  save(random(2334234)+".tif");
}

class Brush {
  PVector location;
  PVector velocity = new PVector(0, 0);
  float angle;
  int life=150;
  color s;

  Brush(PVector _location) {
    location = _location;
  }

  void update() {
    life--;
    if (life<0) {
      life = 100;
      resetPosition();
    }
    s = imgMap.get(int(location.x), int(location.y));
    angle = noise(red(s)*0.001, green(s )*0.001, blue(s)*0.001) * TWO_PI*50;
    velocity= PVector.fromAngle(angle);
    velocity.mult(noise(location.x*0.01, location.y*0.01)*2);
    location.add(velocity);
  }

  void display() {
    fill(s, 20);
    ellipse(location.x, location.y, brushSize, brushSize);
  }

  void resetPosition() {
    location = new PVector(random(width), random(height));
  }
}
