void setup(){
  size(800,600);
  background(0);
  smooth();
}
void draw(){
  float tmp_cant=(int)random(5,8);
  int tmp_size=(int)random(40,80);
  fill(255);
  translate((int)random(width),(int)random(height));
  ellipse(0,0,tmp_size,tmp_size);
  fill(0);
  ellipse(0,0,(tmp_size/tmp_cant),(tmp_size/tmp_cant));
  noFill();
  stroke(0);
  strokeWeight(10/tmp_cant);
  for(int i=1;i<tmp_cant;i++){
    ellipse(0,0,(i*tmp_size/tmp_cant),(i*tmp_size/tmp_cant));
  }
  
}
