import processing.video.*; 
PGraphics img; 
ArrayList<Particle> particles = new ArrayList<Particle>(); 
Movie mov; 
boolean cheatScreen; 
void setup() { 
  
  // Start capturing the images from the camera 
  mov = new Movie(this, "ad.mp4");
  mov.loop();
  mov.read();
  int w =1280;
  int h =720;
  mov.volume(0); //Uncomment if you want to hear the audio
 
  img = createGraphics(w,h); 
  background(0); 
  smooth(); 
  fill(255); 
  size(w, h); 
  for (int i=0;i<60000;i++) particles.add(new Particle());
} 

void draw() {
  if (mov.available() == true) {
    mov.read();
    mov.loadPixels();
    //mov.filter(THRESHOLD);
    background(0); 
    img.beginDraw(); 
    img.background(0); 
    for (Particle p:particles) { 
      p.update(); 
      p.display();
    } 
    img.endDraw(); 
    set(0, 0, img);
    if(cheatScreen) set(0, 0, mov);
  }
  text(frameRate, 20, 20);
} 
class Particle { 
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
    int atemps=0;
    while (brightness (mov.get ( (int)map(pos.x,0,width,0,mov.width), (int)map(pos.y,0,height,0,mov.height)))>50 && atemps < 10) { 
      pos.x = (int)random(width); 
      pos.y = (int)random(height);
      atemps++;
    }
    if(atemps==10) {
      pos.x=-1;
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

