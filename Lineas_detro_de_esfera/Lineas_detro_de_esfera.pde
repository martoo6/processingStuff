import processing.opengl.*;

static int DENSITY = 500;
static int SIZE = 100;
float[][][] pos= new float[DENSITY][3][2];

void setup(){
  size(800,600,OPENGL);
  background(0);
  smooth();
  noFill();
  stroke(255);
    translate(width/2,height/2);
  for(int i=0;i<DENSITY;i++){
    float randomAlpha1=random(2*PI), randomAlpha2=random(2*PI), randomTita1=random(2*PI), randomTita2=random(2*PI);
    pos[i][0][0]=cos(randomAlpha1)*sin(randomTita1)*SIZE;
    pos[i][1][0]=sin(randomAlpha1)*sin(randomTita1)*SIZE;
    pos[i][2][0]=cos(randomTita1)*SIZE;
    pos[i][0][1]=cos(randomAlpha2)*sin(randomTita2)*SIZE;
    pos[i][1][1]=sin(randomAlpha2)*sin(randomTita2)*SIZE;
    pos[i][2][1]=cos(randomTita2)*SIZE;
    //line(x1,y1,z1,x2,y2,z2);
    //point(cos(i)*SIZE,sin(i)*SIZE);
  }
}

void draw(){
  background(0);
    camera(mouseX, mouseY, mouseY, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
         beginShape(LINES);
    for(int i=0;i<DENSITY;i++){
      
      //curveVertex(pos[i][0][0],pos[i][1][0],pos[i][2][0]);
      //curveVertex(pos[i][0][1],pos[i][1][1],pos[i][2][1]);
      
    }
    
     for(int i=0;i<DENSITY;i++){
      vertex(pos[i][0][0],pos[i][1][0],pos[i][2][0]);
      vertex(pos[i][0][1],pos[i][1][1],pos[i][2][1]);
    }
    endShape(); 
}
