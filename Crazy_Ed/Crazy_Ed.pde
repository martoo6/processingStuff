import processing.opengl.*;

int maxformas =60;
Forma[] formas = new Forma[maxformas];
boolean fondo=false,rand=false;
PImage a;


void setup(){
  size(800,600);
  background(0);
  smooth();
  frameRate(30);
  a = loadImage("./1.png");
  for(int i=0;i<maxformas;i+=1){
    int rX = (int)random(width);
    float rS = random(5);
    formas[i]= new Ed(rX,600,rS);
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
    if(y+tam<=0){
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
    tamLast = tam;
    if(tam==0){
      tam=5;
    }
    tam=(int)random(tamLast/3,tamLast);
  }
  void updateSizeNoRand(){
    tam = tamLast;
  }
}

class Ed extends Forma{
  Ed(float xpos, float ypos, float s){
    x=xpos;
    y=ypos;
    speed=s;
    tam=5;
    tamLast = tam;
  }
  void display(){
    pushMatrix();
    translate(x, y);
    rotate(y*0.001);
    image(a, x, y, a.width*0.01*tam, a.height*0.01*tam);
    popMatrix();
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
    for(float t=0;t<2*PI;t+=PI/20){
      line(0,0,cos(t)*tam,sin(t)*tam);
//      line(0,0,lineas[t][0]*tam,lineas[t][1]*tam);
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
      maxformas-=2;
      for(int i =0;i<maxformas;i++){
        formas[i].updateSizeUp();
      }
    }
    if (keyCode == DOWN) {
      maxformas+=2;
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
  if(key=='1'){
    a = loadImage("./1.png");
  }
  if(key=='2'){
    a = loadImage("./2.png");
  }
  if(key=='3'){
    a = loadImage("./3.png");
  }
  if(key=='4'){
    a = loadImage("./4.png");
  }
  if(key=='5'){
    a = loadImage("./5.png");
  }
}
