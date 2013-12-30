int CANTPOINTS = 1000; 
ArrayList points = new ArrayList(); 
void setup() { 
  size(800, 700); 
  colorMode(HSB); 
  for (int i=0;i<CANTPOINTS;i++) { 
    PVector v = new PVector(random(width), random(height)); 
    points.add(v);
  } 
  background(0);
} 
void draw() { 
  for (int i=0;i<points.size();i++) { 
    PVector point = (PVector)points.get(i); 
    PVector dir = PVector.fromAngle(noise(point.x*0.01, point.y*0.01)*360); 
    dir.mult(random(1)); 
    point.x+=dir.x; 
    point.y+=dir.y; 
    stroke(noise(point.x*0.01, point.y*0.01)*255, 255, 255, 30); 
    //stroke(noise(point.x*0.01)*255,noise(point.y*0.01)*255,(abs(dir.heading())/TWO_PI)*255);
    point(point.x, point.y);
  }
} 
void mousePressed() { 
  for (int i=0;i<100;i++) { 
    points.add(new PVector(random(width), random(height)));
  }
}

