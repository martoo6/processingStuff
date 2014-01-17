int MAXLINES=100;
float strokeline=2;
float[][] lala = new float[2000+1][2];
float []opacidad = {0,55,125,255};
boolean record=false;

void setup(){
  size(800,600);
  frameRate(10);
  int a=0;
  int radio=40;
  smooth();
  strokeWeight(strokeline);
  for(float i=0;i<PI*2;i+=PI/(MAXLINES/2)){
    lala[a][0]=radio*cos(i);
    lala[a][1]=radio*sin(i);
    a++;
  }
  //noLoop();
}

void draw(){
  noFill();
  background(0);
  translate(width/2,height/2);
  float inc=1.1;
  for(int i=0;i<MAXLINES;i++){
    stroke(255,opacidad[(int)random(3)]);
    line(lala[i][0]*inc,lala[i][1]*inc,lala[i][0]*inc*2,lala[i][1]*inc*2);
    stroke(255,opacidad[(int)random(3)]);
    line(lala[i][0]*inc*2,lala[i][1]*inc*2,lala[i][0]*inc*3,lala[i][1]*inc*3);
    stroke(255,opacidad[(int)random(3)]);
    line(lala[i][0]*inc*3,lala[i][1]*inc*3,lala[i][0]*inc*4,lala[i][1]*inc*4);
  }
  if (record) {
    saveFrame("circles-####.tif");
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') record=!record;  
  if (key == CODED) {
    if (keyCode == UP) {
      if(MAXLINES<=1997){
        MAXLINES+=2;
      }
    }
    if (keyCode == DOWN) {
      if(MAXLINES>=3){
        MAXLINES-=2;
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
