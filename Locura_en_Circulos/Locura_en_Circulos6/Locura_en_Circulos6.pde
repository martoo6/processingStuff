int maxcircles =200;
Circle[] circulos = new Circle[maxcircles];
boolean fondo=false,rand=false;

void setup(){
  size(800,600);
  smooth();
  frameRate(30);
  for(int i=0;i<maxcircles;i++){
    int rX = (int)random(width);
    float rS = random(5);
    int a=(int)random(255);
    color rC = color(255,a,a,(int)random(255));
    circulos[i]=new Circle(rX,height,rS,rC); 
  }
}
void draw(){
  if(fondo){
    background(0);
  }
  for(int i=0;i<maxcircles;i++){
    circulos[i].display();
    circulos[i].update();
  }
}

class Circle{
  float x, y, speed;
  color relleno;
  int tam;
  int tamLast;
  Circle(float xpos, float ypos, float s){
    x=xpos;
    y=ypos;
    speed=s;
    relleno=255;
    tam=5;
  }
  Circle(float xpos, float ypos, float s, color c){
    x=xpos;
    y=ypos;
    speed=s;
    relleno=c;
    tam=5;
  }
  Circle(float xpos, float ypos, float s, color c, int t){
    x=xpos;
    y=ypos;
    speed=s;
    relleno=c;
    tam=t;
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
    ellipse(0, 0, tam, tam);
    popMatrix();
  }
  void updateSizeUp(){
    tam+=5;
  }
  void updateSizeDown(){
    tam-=5;
  }
  void updateSizeRand(){
    if(tam==0){
      tam=5;
    }
    tamLast = tam;
    tam=5+(int)random(40);
  }
  void updateSizeNoRand(){
    tam = tamLast;
  }
}


void mousePressed()
{
  if(fondo==false){
    fondo=true;
  }else{
    fondo=false;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      for(int i =0;i<maxcircles;i++){
        circulos[i].updateSizeUp();
      }
    }
    if (keyCode == DOWN) {
      for(int i =0;i<maxcircles;i++){
        circulos[i].updateSizeDown();
      }
    }
  }
  if(key=='r'){
    if(rand==true){
      for(int i =0;i<maxcircles;i++){
        circulos[i].updateSizeRand();
      }
      rand=false;
    }else{
      for(int i =0;i<maxcircles;i++){
        circulos[i].updateSizeNoRand();
      }
      rand=true;
    }
  }
}
