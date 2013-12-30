PImage img;
ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  
  background(0);
  smooth();
  stroke(255,10);
  
  img = loadImage("http://www.michelbergerhotel.com/blog/wp-content/2009/06/mh-blog-t-shirt-typo.jpg");
  size(img.width, img.height);
  
  for(int i=0;i<10000;i++) particles.add(new Particle(img));
}

void draw() {
 
 for(Particle p:particles) p.update(); 
 for(Particle p:particles) p.display(); 

  for (int i = particles.size()-1; i >= 0; i--) {
    Particle b = particles.get(i);
    if (b.done()) particles.remove(i);
  }
  
}

class Particle
{
  PVector pos;
  float size;
  float speed=2;
  long aliveTime=(int)random(1,20);
  
  // Constructor
  Particle(PImage img) {
    pos = new PVector();
    pos.x = (int)random(width);
    pos.y = (int)random(height);
    while(brightness(img.get((int)pos.x,(int)pos.y))>80){
      pos.x = (int)random(width);
      pos.y = (int)random(height);
    }
    size = random(1, 4);
  }

  void update(){
    pos.y+=speed;
    aliveTime--;
  }

  boolean done(){
    return pos.y-size > height || aliveTime==0;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, size, size);
    //point(0,0);
    popMatrix();
  }

}

