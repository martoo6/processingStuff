void setup(){
  size(800,600);
  fill(255,100);
  noStroke();
}

void draw(){
  background(0 );
  translate(width/2,height/2);
  for(int a=1;a<1000;a+=20){
    float step = (1.5*TWO_PI)/a;
    for(float i=0;i<TWO_PI;i+=step){
      ellipse(cos(i)*a, sin(i)*a, 20,20);
    } 
  }
}
