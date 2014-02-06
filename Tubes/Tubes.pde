State currentState;
PVector currentPos = new PVector(width/2, height/2);

void setup(){
  size(1280,720);
  noFill();
  background(0 );
  strokeWeight(4);
  stroke(255, 100);
}

void stateConfigurator(){
  State stateUp = new State("Up", new PVector(0,-1));
  
  State stateDown = new State("Down", new PVector(0,1));
  
  State stateRight = new State("Right", new PVector(1,0));
  
  State stateLeft = new State("Left", new PVector(-1,0));
  
  stateUp.addState(stateRight)
         .addState(stateLeft)
         .addState(stateUp);
  
  stateDown.addState(stateDown)
           .addState(stateRight)
           .addState(stateLeft);
  
  stateRight.addState(stateUp)
            .addState(stateDown)
            .addState(stateRight);
  
  stateLeft.addState(stateUp)
           .addState(stateDown)
           .addState(stateLeft);
  
  currentState=stateUp;
}

void draw(){
  float step = random(10,20);
  State nextState = currentState.nextState.get((int)(random(currentState.nextState.size())));
  PVector c = currentState.mov.get( );
  PVector n = nextState.mov.get();
  c.mult(step);
  n.mult(step);
  
  pushMatrix();
  translate(currentPos.x,currentPos.y);
  bezier(0,0,c.x,c.y,c.x,c.y,c.x+n.x,c.y+n.y);
  popMatrix();
  
  currentPos.add(c);
  currentPos.add(n);
  if(currentPos.x>width || currentPos.y>height || currentPos.x<0 || currentPos.y<0) currentPos = new PVector(width/2, height/2);
  
  currentState = nextState;
}

public class State{
  String name;
  PVector mov;
  ArrayList<State> nextState = new ArrayList<State>();
  
  State(String name, PVector mov){
    this.name= name;
    this.mov = mov;
  }
  
  State addState(State state){
    nextState.add(state);
    return this;
  }
}
