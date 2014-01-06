PVector[] pts = new PVector[3];
float[] pend = new float[3];
float[] orig = new float[3];
PVector[] ptsR = new PVector[3];
PVector[] ptsR2 = new PVector[3];
int cp = 0;
PVector centro = new PVector();
float radio = 0;

void setup(){
  size(1400,700);
  background(0);
  for(int i=0;i<3;i++){
    pts[i]=new PVector(0,0).random2D();
    ptsR[i]=new PVector(0,0).random2D();
    ptsR2[i]=new PVector(0,0).random2D();
  }
  stroke(255);
}

void draw(){
  background(0);
  ellipse(centro.x, centro.y, radio, radio);
  line(pts[0].x, pts[0].y, pts[1].x, pts[1].y);
  line(pts[1].x, pts[1].y, pts[2].x, pts[2].y);
  line(pts[2].x, pts[2].y, pts[0].x, pts[0].y);
  line(ptsR[0].x,ptsR[0].y,ptsR2[0].x,ptsR2[0].y);
  line(ptsR[1].x,ptsR[1].y,ptsR2[1].x,ptsR2[1].y);
  line(ptsR[2].x,ptsR[2].y,ptsR2[2].x,ptsR2[2].y);
}

void mouseReleased() {
  pts[cp].x = mouseX;
  pts[cp].y = mouseY;
  
  //Mitad de la recta
  ptsR[0] = pts[0].get();
  ptsR[0].sub(pts[1]);
  ptsR[0].div(2);
  
  ptsR[1] = pts[1].get();
  ptsR[1].sub(pts[2]);
  ptsR[1].div(2);
  
  ptsR[2] = pts[2].get();
  ptsR[2].sub(pts[0]);
  ptsR[2].div(2);
  
  //Mitad de la recta rotada
  ptsR2[0] = pts[0].get();
  ptsR2[0].add(ptsR[0]);
  ptsR[0].rotate(PI);
  ptsR2[0].add(ptsR[0]);
  ptsR[0].rotate(PI);

  ptsR2[1] = pts[1].get();
  ptsR2[1].add(ptsR[1]);
  ptsR[1].rotate(PI);
  ptsR2[1].add(ptsR[1]);
  ptsR[1].rotate(PI);
  
  ptsR2[2] = pts[2].get();
  ptsR2[2].add(ptsR[2]);
  ptsR[2].rotate(PI);
  ptsR2[2].add(ptsR[2]);
  ptsR[2].rotate(PI);
  //
  ptsR[0].add(pts[0]);
  ptsR[1].add(pts[1]);
  ptsR[2].add(pts[2]);
  //Pendientes
  pend[0]=(ptsR[0].y -ptsR2[0].y)/(ptsR[0].x + ptsR2[0].x);
  pend[1]=(ptsR[1].y -ptsR2[1].y)/(ptsR[1].x + ptsR2[1].x);
  pend[2]=(ptsR[2].y -ptsR2[2].y)/(ptsR[2].x + ptsR2[2].x);
  //Coord al origen
  orig[0] = ptsR[0].y-pend[0]*ptsR[0].x;
  orig[1] = ptsR[1].y-pend[1]*ptsR[1].x;
  orig[2] = ptsR[2].y-pend[2]*ptsR[2].x;
  //Centro del circulo
  centro.x = orig[1]-orig[0]/(pend[0]-pend[1]);
  centro.y = pend[0]*centro.x+orig[0];
  //Radio
  radio = centro.dist(pts[0]);
  cp++;
  if(cp==3) cp=0;
}
