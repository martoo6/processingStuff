final int CANT=50;
PVector points[] = new PVector[CANT];
final int speed=10;

void setup(){
  size(800,600);
  background(0);
  stroke(255,20);
  for(int i=0;i<CANT;i++) points[i]= new PVector(random(width), random(height));
}

void draw(){
  fill(noise(frameCount*0.001)*255,noise(frameCount*0.001+1)*255,noise(frameCount*0.001+2)*255, 10);
  for(int e=0;e<speed;e++){
    int pos[] = new int[4];
    for(int i=0;i<4;i++) pos[i] = (int)random(CANT);
    curve(points[pos[0]].x, points[pos[0]].y, points[pos[1]].x, points[pos[1]].y, points[pos[2]].x, points[pos[2]].y, points[pos[3]].x, points[pos[3]].y);
  }
}
