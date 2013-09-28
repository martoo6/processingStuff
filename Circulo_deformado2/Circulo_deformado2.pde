int radioBase=300;

void setup(){
  size(800,700);
  smooth();
  noLoop();
  colorMode(HSB, 255);
}

void draw(){
  background(255);
  translate(width/2,height/2);
  float i=0;
  int a=0;
  for(i=0;i<PI*2;i+=PI/10){
    int radio = radioBase;
    float intensidad=255;
    for(float e=i;e<PI*5;e+=PI/10){
      fill(a,intensidad,255);
      stroke(a,intensidad,255);
      beginShape();
      
      for(float b=e;b<e+(PI/10);b+=PI/200){
        vertex(radio*cos(b),radio*sin(b));
      }
      
      vertex(radio*cos(e+(PI/10)),radio*sin(e+(PI/10)));
      vertex(radio*0.9*cos(e+(PI/10)),radio*0.9*sin(e+(PI/10)));
      for(float b=e+(PI/10);b>e;b-=PI/200){
        vertex(radio*0.9*cos(b),radio*0.9*sin(b));
      }
      
      
      vertex(radio*0.9*cos(e),radio*0.9*sin(e));
      
      vertex(radio*cos(e),radio*sin(e));
      endShape();
      radio *= 0.9;
      intensidad*=0.9;
    }
    a+=12;
  }
  
}
