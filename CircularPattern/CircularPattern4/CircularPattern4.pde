void setup(){
  size(800,600);
  noFill();
  stroke(255,40);
}

void draw(){
  background(0 );
  translate(width/2,height/2);
  for(int i=0;i<10;i++) drawCircle(i*0.01);
}

void drawCircle(float seed){
  for(int i=0;i<10;i++){
    rotate(noise(i*0.001, frameCount*0.0001, seed)*(height/2));
    float s = noise(seed, frameCount*0.01)*(height/2);
    triangle(0,s,s,0,-s,0);
  }
}
