public class Element{
  public long id = this.hashCode();
  public PVector pos= new PVector(random(width),random(height));
  public PVector lastPos= new PVector(pos.x, pos.y);
  public float radius=random(5,10);
  public color myColor = color(255);
  private ArrayList<MovementObserver> movementObservers = new ArrayList<MovementObserver>();
  
  public void render(){
    fill(myColor);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
  
  public boolean collided(Element element){
    if(dist(pos.x, pos.y, element.pos.x, element.pos.y)<element.radius+radius) return true;
    return false;
  }
  
  public void move(float x, float y){
    lastPos.x=pos.x;
    lastPos.y=pos.y;
    pos.x+=x;
    pos.y+=y;
    for(MovementObserver observer:movementObservers) observer.hasMoved(this);
  }
  
  public void move(float amount){
    lastPos.x=pos.x;
    lastPos.y=pos.y;
    pos.x+=cos(noise(pos.x*detail, pos.y*detail)*TWO_PI)*amount;
    if(pos.x>=width){
      pos.x=0;
    }
    if(pos.x<0){
      pos.x=width-1;
    }
    pos.y+=sin(noise(pos.x*detail, pos.y*detail)*TWO_PI)*amount;
    if(pos.y>=height){
      pos.y=0;
    }
    if(pos.y<0){
      pos.y=height-1;
    }
    for(MovementObserver observer:movementObservers) observer.hasMoved(this);
  }
  
  Element addObserver(MovementObserver observer){
    movementObservers.add(observer);
    return this;
  }
  
  void destroy(){
    for(MovementObserver observer:movementObservers) observer.destroyed(this);
  }
}
