float strokeline=1;
int radioBase=300;
color []colores= new color[400];

void setup(){
  size(800,600);
  background(0);
  smooth();
  noLoop();
  colorMode(HSB, 255);
}

void draw(){
  background(0);
  translate(width/2,height/2);
  float i=0;
  int a=0;
  for(i=0;i<PI*2;i+=PI/20){
    int radio = radioBase;
    int intensidad=255;
    for(float e=i;e<PI*4;e+=PI/20){
      fill(a,255,intensidad);
      stroke(a,255,intensidad);
      beginShape();
      vertex(radio*cos(e),radio*sin(e));
      vertex(radio*cos(e+(PI/20)),radio*sin(e+(PI/20)));
      vertex(radio*0.9*cos(e+(PI/20)),radio*0.9*sin(e+(PI/20)));
      vertex(radio*0.9*cos(e),radio*0.9*sin(e));
      vertex(radio*cos(e),radio*sin(e));
      endShape();
      radio *= 0.9;
      intensidad-=10;
    }
    a+=5;
  }
  
}
