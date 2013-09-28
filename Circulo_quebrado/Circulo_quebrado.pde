float strokeline=1;
int radio=10;
float[][] lala = new float[300][2];

void setup(){
  size(800,600);
  background(0);
  stroke(255);
  int a=0;
  smooth();
  for(float i=0;i<PI*2;i+=PI/100){
    lala[a][0]=radio*cos(i);
    lala[a][1]=radio*sin(i);
    a++;
  }
}

void draw(){
  noFill();
  background(0);
  translate(width/2,height/2);
  strokeWeight(strokeline);
  beginShape();
  for(int i=0;i<200;i++){
    curveVertex(lala[i][0]+random(10),lala[i][1]+random(10));
  }
  endShape();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if(radio<=height){
        radio+=2;
      }
    }
    if (keyCode == DOWN) {
      if(radio>=3){
        radio-=2;
      }
    }
    if (keyCode == LEFT) {  
    strokeline-=0.5;
    if(strokeline<=0){
      strokeline=0.1;  
    }
    }
    if (keyCode == RIGHT) {
      if(strokeline<100){
        strokeline+=0.5;
      }
    }
  }
  setup();
}
