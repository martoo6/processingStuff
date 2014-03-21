final int CANT=5;
PVector points[] = new PVector[CANT];
final int speed=1;

void setup(){
  size(800,600);
  background(0);
  noFill();
  stroke(255,10);  
  for(int i=0;i<CANT;i++) points[i]= new PVector(random(width), random(height));
}

void draw(){
  //stroke(random(255),random(255),random(255), 100);
  for(int e=0;e<speed;e++){
    int pos[] = new int[4];
    for(int i=0;i<4;i++) pos[i] = (int)random(CANT);
    curve(points[pos[0]].x, points[pos[0]].y, points[pos[1]].x, points[pos[1]].y, points[pos[2]].x, points[pos[2]].y, points[pos[3]].x, points[pos[3]].y);
  }
}
