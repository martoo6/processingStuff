import processing.opengl.*;

int maxformas =60;
Forma[] formas = new Forma[maxformas];
boolean fondo=false,rand=false;

void setup(){
  size(800,600);
  background(0);
  smooth();
  //frameRate(30);
  for(int i=0;i<maxformas;i+=2){
    int rX = (int)random(width);
    int rZ = (int)random(width);
    float rS = random(5);
    int a=(int)random(255);
    color rC = color(255,a,a,(int)random(255));
    formas[i+1]=new Circle(rX,height,rZ,rS,rC); 
    formas[i]=new Star(rX,height,rZ,rS,(int)random(60)); 
  }
  
}
void draw(){
  if(fondo){
    background(0);
  }
  for(int i=0;i<maxformas;i++){
    formas[i].display();
    formas[i].update();
  }
}

abstract class Forma{
   float x, y,z, speed;
   int tam;
   int tamLast;
   void llenar(){
     this.llenar();
   }
   void display(){
     this.display();
   }
  void update(){
    y-=1+speed;
    x+=sin(y/20)*(5+speed/2);
    if(y<=0){
      y=height;
      x=(int)random(width);//Con el tiempo se desplazan para la derecha
    }
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

class Star extends Forma{
  float lineas[][] = new float[20][2];
  Star(float xpos, float ypos,float zpos, float s){
    x=xpos;
    y=ypos;
    z=zpos;
    speed=s;
    tam=5;
  }
  Star(float xpos, float ypos,float zpos, float s, int t){
    x=xpos;
    y=ypos;
    z=zpos;
    speed=s;
    tam=t;
    for(int tt=0;tt<20;tt++){
      lineas[tt][1]=sin(tt);
      lineas[tt][0]=cos(tt);
    }
  }
  void llenar(){
    
  }
  void display(){
    stroke(255);
    pushMatrix();
    translate(x, y);
    for(int t=0;t<20;t++){
      rotate(random(10));
      line(lineas[t][0]*tam-random(lineas[t][0]*tam),lineas[t][1]*tam-random(lineas[t][1]*tam),lineas[t][0]*tam,lineas[t][1]*tam);
    }
    popMatrix();
  }
}

class Circle extends Forma{
  color relleno;
  void display(){
    noStroke();
    this.llenar();
    pushMatrix();
    translate(x, y);
    ellipse(0, 0, tam, tam);
    popMatrix();
  }
  Circle(float xpos, float ypos,float zpos, float s){
    x=xpos;
    y=ypos;
    z=zpos;
    speed=s;
    relleno=255;
    tam=5;
  }
  Circle(float xpos, float ypos,float zpos, float s, color c){
    x=xpos;
    y=ypos;
    z=zpos;
    speed=s;
    relleno=c;
    tam=5;
  }
  Circle(float xpos, float ypos,float zpos, float s, color c, int t){
    x=xpos;
    y=ypos;
    z=zpos;
    speed=s;
    relleno=c;
    tam=t;
  }
  void llenar(){
    fill(relleno);
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
      for(int i =0;i<maxformas;i++){
        formas[i].updateSizeUp();
      }
    }
    if (keyCode == DOWN) {
      for(int i =0;i<maxformas;i++){
        formas[i].updateSizeDown();
      }
    }
  }
  if(key=='r'){
    if(rand==true){
      for(int i =0;i<maxformas;i++){
        formas[i].updateSizeRand();
      }
      rand=false;
    }else{
      for(int i =0;i<maxformas;i++){
        formas[i].updateSizeNoRand();
      }
      rand=true;
    }
  }
}
