

void setup(){
  size(1280,720);
  background(255);
}

void draw(){
  float x, y, a, b;
  x = random(width);
  y=random(height);
  a=random(10,40);
  b=random(10,40);
  noFill();
  for(int i=0;i<5;i++){
    strokeWeight(5*i);
    stroke(0, 5);
    rect(x,y,a,b);
  }
  noStroke();
  fill(255);
  rect(x,y,a,b);
}
