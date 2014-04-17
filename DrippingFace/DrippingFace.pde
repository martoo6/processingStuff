ArrayList<Particle> particles = new ArrayList<Particle>();
final color white = color(255);

PImage img;

void setup() {
  img = loadImage("http://wiccareencarnada.files.wordpress.com/2013/09/lady-gaga.jpg");
  img.resize((int)(img.width*0.15),(int)(img.height*0.15));  
  background(0);
  smooth();
  stroke(255);
  size(img.width, img.height);
  
  for(int i=0;i<10000;i++) particles.add(new Particle());
}

void draw() {
 background(0);
 for(Particle p:particles) {
   p.update(); 
   p.display();
 }
 saveFrame("#####.png");
}

class Particle
{
  PVector pos;
  float speed;
  int lifeTime;
  
  // Constructor
  Particle() {
    reset();
  }

  void reset(){
    lifeTime= (int)random(2,20);
    speed=1;
    pos = new PVector();
    pos.x = (int)random(width);
    pos.y = (int)random(height);
    while(brightness(img.get((int)pos.x,(int)pos.y))<200){
      pos.x = (int)random(width);
      pos.y = (int)random(height);
    }
  }

  void update(){
    pos.y+=speed;
    speed*=1.3;
    lifeTime--;
    if(pos.y > height || lifeTime ==0) reset();
  }

  void display() {
      set((int)pos.x, (int)pos.y, white);
  }

}
