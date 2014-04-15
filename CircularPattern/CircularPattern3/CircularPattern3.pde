void setup(){
  size(800,600);
  noFill();
  stroke(255,50);
}

void draw(){
  background(0 );
  translate(width/2,height/2);
  for(int i=0;i<5;i++) drawCircle(i*0.1);
}

void drawCircle(float seed){
  for(int i=0;i<100;i++){
    float r1 = noise(i*0.01, frameCount*0.001, seed)*(height/2);
    i++;
    float r2 = noise(i*0.01, frameCount*0.001, seed)*(height/2);
    float a = i+(frameCount*0.01);
    ellipse(cos(a)*r1,sin(a)*r1, cos(a+1)*r2, cos(a+1)*r2); 
  }
}
