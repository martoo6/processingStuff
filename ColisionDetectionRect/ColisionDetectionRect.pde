

void setup(){
  size(1260,720);
}

void draw(){
  background(255);
  PVector p1 = new PVector(random(width ), random(height ));
  PVector p2 = new PVector(random(width ), random(height ));
  PVector p3 = new PVector(random(width ), random(height ));
  PVector p4 = new PVector(random(width ), random(height ));
  
  line(p1.x, p1.y, p2.x, p2.y);
  line(p3.x, p3.y, p4.x, p4.y);
  
  fill(0);
  text(colision(p1,p2,p3,p4)?"Colision!":"Noup",20, 20);
  delay(500);
}

boolean colision(PVector p1, PVector p2, PVector p3, PVector p4) {
  float x1 = p1.x;
  float x2 = p2.x;
  float x3 = p3.x;
  float x4 = p4.x;

  float y1 = p1.y;
  float y2 = p2.y;
  float y3 = p3.y;
  float y4 = p4.y;

  float a = (y2-y1)/(x2-x1);
  float c = (y4-y3)/(x4-x3);

  //Different slope means they might intersect
  if (c!=a) {

    final float b = y1-(a*x1);
    final float d = y3-(c*x3);
    final float min = max(min(x1, x2), min(x3, x4));
    final float max = min(max(x1, x2), max(x3, x4)); 

    float xIntersec = (d-b)/(a-c);

    return (xIntersec>=min && xIntersec<=max);
  }
  return false;
}
