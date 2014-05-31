void setup(){
  size(500,500);
  background(0);
}

void draw(){
  background(0);
}

interface StrategyMovement{
  void update(Point p);
}

class CircularMovement implements StrategyMovement{
  void center;
  float time;
  void update(Point p){
    time = frameCount*0.01;
    p.move(sin(time),cos(time));
  }
} 

class Point{
  PVector pos;
  StrategyMovement strategyMovement;
  
  void move(float x, float y){
    pos.set(x,y);
  }
}
