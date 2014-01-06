PGraphics img;
ArrayList<Particle> particles = new ArrayList<Particle>();


void setup() {
  img = createGraphics(1200, 600);
  img.beginDraw();
  img.background(0);
  img.fill(255);
  img.textSize(300);
  img.textAlign(CENTER, CENTER);
  img.text("FALLING", img.width/2, img.height/2);
  img.endDraw();
  background(0);
  smooth();
  stroke(255);
  size(img.width, img.height);
  
  for(int i=0;i<5000;i++) particles.add(new Particle());
}

void draw() {
 background(0);
 for(Particle p:particles) {
   p.update(); 
   p.display();
 }
  
}

class Particle
{
  PVector pos;
  float speed;
  
  // Constructor
  Particle() {
    reset();
  }

  void reset(){
    speed=1;
    pos = new PVector();
    pos.x = (int)random(width);
    pos.y = (int)random(height);
    while(brightness(img.get((int)pos.x,(int)pos.y))!=255){
      pos.x = (int)random(width);
      pos.y = (int)random(height);
    }
  }

  void update(){
    pos.y+=speed;
    speed*=1.3;
    if(pos.y > height) reset();
  }

  void display() {
      point(pos.x, pos.y);
  }

}

