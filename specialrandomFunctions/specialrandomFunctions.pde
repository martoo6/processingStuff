void setup(){
  size(400,400);
  background(0);
  stroke(255,10);
}

void draw(){
  
  for(int i=0;i<20;i++){
    float x=random(width) ,y = randomLinearFunction(height);
    line(x,y,x+random(-10,10),y+random(-10,10));
  }
  
}


float randomLinearFunction(float h){
  float r1=random(1), r2=random(1);
  final float MAX = h;
  while(r2*MAX>r1*200){
      r1=random(1);
      r2=random(1);
  }
  return r2*MAX; 
}
