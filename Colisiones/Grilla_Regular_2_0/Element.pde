public class Element{
  public long id = millis();//Es suficiente como identificador unico ? Lo dudo...
  public PVector pos= new PVector(random(width),random(height));
  public PVector dest= new PVector(random(width),random(height));
  public float radius=random(1,10);
  public color myColor = color(255);
  
  public void render(){
    fill(myColor);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
  
  public boolean collided(Element element){
    if(dist(pos.x, pos.y, element.pos.x, element.pos.y)<element.radius+radius) return true;
    return false;
  }
  
  public void move(float x, float y){
    pos.x+=x;
    pos.y+=y; 
  }
  
  public void move(float amount){
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
  }
}
