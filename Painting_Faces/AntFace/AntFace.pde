PImage ant;
PImage face;

void setup(){
  ant = loadImage("ant.png");
  face = loadImage("face.jpg");
  face.filter(THRESHOLD);
  size(face.width,face.height);
  noLoop();  
}

void draw(){
  background(255);
  //image(face,mouseX,mouseY);
  imageMode(CENTER);
  for(int i=0;i<1000;i++){
    PVector p = new PVector(random(face.width), random(face.height));
    while(brightness(face.get((int)p.x,(int)p.y))>100) p = new PVector(random(face.width), random(face.height));
    pushMatrix();
    translate(p.x, p.y);
    rotate(random(TWO_PI));
    image(ant, 0, 0, 20, 20);
    popMatrix();
  }
}
