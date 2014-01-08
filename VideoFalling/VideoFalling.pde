import processing.video.*;

PGraphics img;
ArrayList<Particle> particles = new ArrayList<Particle>();
Capture video;
boolean cheatScreen;

void setup() {
  video = new Capture(this, 1280, 720, 30);
  img = createGraphics(1280, 720);
  // Start capturing the images from the camera
  video.start();

  background(0);
  smooth();
  fill(255);
  size(1280, 720);

  for (int i=0;i<60000;i++) particles.add(new Particle());
}

void captureEvent(Capture c) {
  c.read();
  //This is running in parallel, so in cheatSheet mode I may see the image with colors.
  video.filter(THRESHOLD);
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
  set(0,0,img);
  if(cheatScreen) image(video,0,0);
  text(frameRate, 20,20);
}

class Particle
{
  PVector pos;
  float speed;
  int lifeTime;
  final int baseLifeTime = (int)random(5,20);

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
    while (brightness (video.get ( (int)pos.x, (int)pos.y))!=255) {
      pos.x = (int)random(width);
      pos.y = (int)random(height);
    }
  }

  void update() {
    lifeTime--;
    pos.y+=speed;
    speed+=1;
    if (pos.y > height || lifeTime==0) reset();
  }

  void display() {
    img.set((int)pos.x,(int) pos.y, color((255*lifeTime)/baseLifeTime));
  }
}


void keyPressed() {
  switch (key) {
    case 'g': saveFrame(); break;
    case 'c': cheatScreen = !cheatScreen; break;
  }
}
