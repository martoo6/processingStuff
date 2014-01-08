import processing.video.*; 
PGraphics img; 
ArrayList<Particle> particles = new ArrayList<Particle>(); 
Movie mov; 
boolean cheatScreen; 
void setup() { 
  
  // Start capturing the images from the camera 
  mov = new Movie(this, "ad.mp4");
  mov.loop();
  mov.volume(0); //Uncomment if you want to hear the audio
 
 img = createGraphics(480, 360); 
  background(0); 
  smooth(); 
  fill(255); 
  size(480, 360); 
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
    while (brightness (mov.get ( (int)pos.x, (int)pos.y))>50) { 
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

