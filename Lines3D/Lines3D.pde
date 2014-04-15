void setup(){
  size(800,600,P3D);
  background(0 );
  stroke(255);
  noFill();
}

void draw(){
  background(0 );
  float h=300;
  for(int i=0;i<20;i++){
    beginShape( );
    for(int x=0;x<600;x++){
      vertex(x,noise(x*0.01)*h,i*50);
    }
    endShape();
  }
}
