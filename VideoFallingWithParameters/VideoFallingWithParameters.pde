import processing.video.*;
import controlP5.*;

ControlP5 cp5;
PGraphics img;
ArrayList<Particle> particles = new ArrayList<Particle>();
Capture video;
boolean cheatScreen;

int brightnessMax;
int brightnessMin;

Range range;

void setup() {
  video = new Capture(this, 640, 480, 30);
  img = createGraphics(1280, 720);
  // Start capturing the images from the camera
  video.start();

  background(0);
  smooth();
  fill(255);
  size(1280, 720);

  cp5 = new ControlP5(this);
  range = cp5.addRange("rangeController")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
      .setPosition(20, 20)
        .setSize(200, 30)
          .setHandleSize(20)
            .setRange(0, 255)
              .setRangeValues(50, 100)
                // after the initialization we turn broadcast back on again
                .setBroadcast(true)
                  .setColorForeground(color(255, 40))
                    .setColorBackground(color(255, 40))  
                      ;


  for (int i=0;i<60000;i++) particles.add(new Particle());
}

void captureEvent(Capture c) {
  c.read();
  //This is running in parallel, so in cheatSheet mode I may see the image with colors.
  //video.filter(THRESHOLD);
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom("rangeController")) {
    brightnessMin = (int)theControlEvent.getController().getArrayValue(0);
    brightnessMax = (int)theControlEvent.getController().getArrayValue(1);
  }
}

void draw() {
  background(0);  
  img.beginDraw();
  img.background(0);

  for (Particle p:particles) {
    p.update(); 
    p.display();
  }
  img.endDraw();
  set(0, 0, img);
  if (cheatScreen) image(video, 0, 0);
  text(frameRate, width - 50, 20);
}

class Particle
{
  PVector pos;
  float speed;
  int lifeTime;
  final int baseLifeTime = (int)random(5, 20);

  // Constructor
  Particle() {
    reset();
  }

  void reset() {
    lifeTime=baseLifeTime;
    speed=1;
    pos = new PVector();
    pos.x = (int)random(width);
    pos.y = (int)random(height);
    int b = (int)brightness (video.get ( (int)pos.x, (int)pos.y));
    int atemps=0;
    while ((b < brightnessMin || b > brightnessMax) && atemps < 10) {
      pos.x = (int)random(width);
      pos.y = (int)random(height);
      b = (int)brightness (video.get ( (int)pos.x, (int)pos.y));
      atemps++;
    }
    if(atemps==10) {
      pos.x=0;
      pos.y=0;
    } 
  }

  void update() {
    lifeTime--;
    pos.y+=speed;
    speed+=1;
    if (pos.y > height || lifeTime==0) reset();
  }

  void display() {
    img.set((int)pos.x, (int) pos.y, color((255*lifeTime)/baseLifeTime));
  }
}


void keyPressed() {
  switch (key) {
  case 'g': 
    saveFrame(); 
    break;
  case 'c': 
    cheatScreen = !cheatScreen; 
    break;
  }
}

