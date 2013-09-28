int maxcircles =200;
Circle[] circulos = new Circle[maxcircles];

void setup(){
  size(800,600);
  for(int i=0;i<maxcircles;i++){
    int rX = (int)random(width);  
    float rS = random(10);
    circulos[i]=new Circle(rX,height,rS);
  }
}
void draw(){
  for(int i=0;i<maxcircles;i++){
    circulos[i].display();
    circulos[i].update();
  }
}

class Circle{
  float x, y, speed;
  Circle(float xpos, float ypos, float s){
    x=xpos;
    y=ypos;
    speed=s;
    
  }
  void update(){
    y-=1+speed;
    x+=sin(y)*speed;
    if(y<=0){
      y=height;
    }
  }
  void display(){
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    translate(x, y);
    ellipse(0, 0, 40, 40);
    popMatrix();
  }
}


void mousePressed()
{
  setup();
}

