void setup(){
  size(800,600);
  background(0);
  noLoop();
  stroke(255);
  noFill();
}

void draw(){
  background(0);
  
  for(int i=0;i<10;i++){
    beginShape();
    for(int x=0;x<width;x+=width/20){
      curveVertex(x,noise(x*0.01,i*0.02)*400 + i*20);
    }
    endShape();
  }
  
}
