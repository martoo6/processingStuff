PGraphics img;
ArrayList<Particle> particles = new ArrayList<Particle>();
final color white = color(255, 20);

void setup() {
  img = createGraphics(1200, 600);
  img.beginDraw();
  img.background(0);
  img.fill(255);
  img.textSize(250);
  img.textAlign(CENTER, CENTER);
  img.text("DRIPPING", img.width/2, img.height/2);
  img.endDraw();
  background(0);
  smooth();
  stroke(255);
  size(img.width, img.height);
  
  for(int i=0;i<1000;i++) particles.add(new Particle());
}

void draw() {
 //fill(0,10);
 //rect(0,0,width, height);
 for(Particle p:particles) {
   p.update(); 
   p.display();
 }
  
}

class Particle
{
  PVector pos;
  int lifeTime;
  
  // Constructor
  Particle() {
    reset();
  }

  void reset(){
    lifeTime= (int)random(2,90);
    pos = new PVector();
    pos.x = (int)random(width);
    pos.y = (int)random(height);
    while(brightness(img.get((int)pos.x,(int)pos.y))!=255){
      pos.x = (int)random(width);
      pos.y = (int)random(height);
    }
  }

  void update(){
    pos.y++;
    lifeTime--;
    if(pos.y > height || lifeTime ==0) reset();
  }

  void display() {
    stroke(white);
      point((int)pos.x, (int)pos.y);
  }

}
