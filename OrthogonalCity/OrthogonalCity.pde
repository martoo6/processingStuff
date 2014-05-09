void setup() {  
  size(500, 500, P3D);
  ortho();
  background(0);
  noFill();
  stroke(255);
}

void draw() {
  background(0);
  rotateX(-PI/4);
  rotateY(-PI/4);

  for (int i=0;i<10;i++) {
    pushMatrix();
    translate(noise(i)*width, noise(i*i)*400, 0);
    box(40);
    popMatrix();
  }
}



abstract class Building {
  color c=color(200+random(50), 0, random(50));
  float w=random(20,50);
  float l=random(20,50);
  abstract void render();
}

class Skyscraper extends Building {
  float h= random(50,100);
  void render() {
    fill(c);
    pushMatrix();
    float tmpH=map(h,50,100,2,4);
    for(int i=0;i<map(h,50,100,2,4);i++) {
      box(w,tmpH,l);
    }
    popMatrix();
  }
}

class House extends Building {
  void render() {
    fill(c);
  }
}
