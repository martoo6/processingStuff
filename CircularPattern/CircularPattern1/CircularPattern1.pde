void setup(){
  size(800,600);
  stroke(255,200);
  noFill();
}

void draw(){
  background(0 );
  translate(width/2,height/2);
  for(int i=0;i<10;i++) drawCircle(i);
}

void drawCircle(float seed){
  beginShape();
  for(int i=0;i<100;i++){
    float r = noise(i*0.0001, frameCount*0.001, seed)*(height*.50);
    float a = i+(frameCount*0.01);
    if(int(seed)%2==0) a=TWO_PI-a;
    vertex(cos(a)*r,sin(a)*r);
  }
  endShape();
}
