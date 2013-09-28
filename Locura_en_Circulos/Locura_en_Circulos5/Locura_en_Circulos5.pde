int maxcircles =200;
Circle[] circulos = new Circle[maxcircles];
//boolean fondo=0;

void setup(){
  size(800,600);
  //smooth();
  //frameRate(30);
  for(int i=0;i<maxcircles;i++){
    int rX = (int)random(width);
    float rS = random(5);
    int a=(int)random(255);
    color rC = color(255,a,a,(int)random(255));
    circulos[i]=new Circle(rX,height,rS,rC);
  }
}
void draw(){
  //if(fondo){
  //  background(0);
  //}
  //background(0);
  for(int i=0;i<maxcircles;i++){
    circulos[i].display();
    circulos[i].update();
  }
}

class Circle{
  float x, y, speed;
  color relleno;
  Circle(float xpos, float ypos, float s){
    x=xpos;
    y=ypos;
    speed=s;
    relleno=255;
  }
  Circle(float xpos, float ypos, float s, color c){
    x=xpos;
    y=ypos;
    speed=s;
    relleno=c;
  }
  void update(){
    y-=1+speed;
    x+=sin(y/20)*(5+speed/2);
    if(y<=0){
      y=height;
      x=(int)random(width);//Con el tiempo se desplazan para la derecha
    }
  }
  void display(){
    noStroke();
    fill(relleno);
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

