void setup(){
  size(800,600);
  stroke(255);
  fill(0,30);
}

void draw(){
  rect(0,0,width, height);
  translate(width/2,height/2);
  for(float i=0;i<TWO_PI;i+=TWO_PI/1000){
    float r = noise(i*10)*(width/2);
    float a = i+(frameCount*10)/(r*r*0.1);
    point(cos(a)*r,sin(a)*r);
  }
  
}
