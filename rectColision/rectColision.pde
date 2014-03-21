void setup(){
  size(800,600);
  background(0);
}

void draw(){
  background(0);
  PVector p1 =new PVector(random(width), random(height));
  PVector p2 =new PVector(random(width), random(height));
  PVector p3 =new PVector(random(width), random(height));
  PVector p4 =new PVector(random(width), random(height));
  stroke(255);
  line(p1.x, p1.y, p2.x, p2.y);
  line(p3.x, p3.y, p4.x, p4.y);
  fill(255);
  String s = rectIntersect(p1,p2,p3,p4)? "Colission !": "Noup";
  text(s, 20, 20);
}


boolean rectIntersect(PVector p1, PVector p2, PVector p3,PVector p4){
  float a= (p1.y-p2.y)/(p1.x-p2.x);
  float c= (p3.y-p4.y)/(p3.x-p4.x);
  if(a!=c){ //Same slope means no colission
    float b = p1.y-(a*p1.x);
    float d = p3.y-(c*p3.x);
    
    float xIntersect = ((d-b)/(a-c));
    println(xIntersect, p1.x, p2.x, p3.x, p4.x);
    if(xIntersect>=min(p1.x, p2.x) && xIntersect>=min(p3.x, p4.x) && xIntersect<=max(p1.x, p2.x) && xIntersect<=max(p3.x, p4.x) ) return true;
  }
  return false;
}
