Position up = new Position(new PVector(0,1), new PVector(0,1));
Position upRight = new Position(new PVector(1,1), new PVector(0,1));
Position upLeft = new Position(new PVector(-1,1), new PVector(0,1));

Position down = new Position(new PVector(0,-1), new PVector(0,-1));
Position downRight = new Position(new PVector(1,-1), new PVector(0,-1));
Position downLeft = new Position(new PVector(-1,-1), new PVector(0,-1));

Position right = new Position(new PVector(1,0), new PVector(1,0));
Position rightUp = new Position(new PVector(1,-1), new PVector(1,0));
Position rightDown = new Position(new PVector(1,1), new PVector(1,0));

Position left = new Position(new PVector(1,0), new PVector(1,0));
Position leftUp = new Position(new PVector(-1,-1), new PVector(-1,0));
Position leftDown = new Position(new PVector(-1,1), new PVector(-1,0));

up.addPositions();
upRight.addPositions();
upLeft.addPositions();
down.addPositions();
downRight.addPositions();
downLeft.addPositions();
right.addPositions();
rightUp.addPositions();
rightDown.addPositions();
left.addPositions();
leftUp.addPositions();
leftDown.addPositions();

Trace t = new Trace();

void setup(){
  size(displayWidth, displayHeight);
}

void draw(){
  t.update();
  t.render();
}

class Trace{
  State s = new fromUp();
  Position destPosition = new Position();
  PVector currentPos;
  float currentTime=0;
  
  void update(){
    currentTime+=0.01;
    if(currentTime=1){
      currentPos = destPos.PosPoint;
      
      
      tmpDestPos = getNextMov();
      destPos.PosPoint = tmpDestPos.PosPoint.get();
      destPos.ControlPoint = tmpDestPos.ControlPoint.get();
      
      float tmpMult = random(5,10);
      destPos.PosPoint.mult(tmpMult)
      destPos.ControlPoint.mult(tmpMult)
      
      destPos.PosPoint.add(currentPos);
      destPos.ControlPoint.add(currentPos);
      
      s = destPos.state;
    }
  }
  void render(){
    float x = bezierPoint(currentPos.x, destPos.ControlPoint.x, destPos.ControlPoint.x, destPos.PosPoint.x, currentTime);
    float y = bezierPoint(currentPos.y, destPos.ControlPoint.y, destPos.ControlPoint.y, destPos.PosPoint.y, currentTime);
    line(lastX, lastY, x, y);
  }
}

class Position{
  PVector ControlPoint;
  PVector PosPoint;
  Position[] positions
  
  public Position(PVector ControlPoint, PVector PosPoint, State state){
    this.ControlPoint = ControlPoint;
    this.PosPoint = PosPoint;
    this.state = state;
  }
  
  Position getNextMov(){
    return positions[(int)random(3)];
  }
  
  void addPositions(){
    
  }
}
