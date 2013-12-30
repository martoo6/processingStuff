color colores[] = {#4340F7, #8429E5, #FC508A, #07BD8D, #B62740};

void setup(){
  size(displayWidth-100,300);
  stroke(colores[(int)random(colores.length)], 30);
  smooth();
  ellipseMode(CORNER);
}

void draw(){
  background(255);
  fill(0);
  text(frameRate, 20, 20);
  
  fill(255);
  for(float i=0;i<width;i++){
    float s = noise(i*0.01)*100;
    ellipse(i,height/2,s,s);
  }
}
