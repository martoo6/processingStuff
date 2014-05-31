import peasy.*;

PeasyCam cam;


Boolean axis=false;
float size=500;
float s = 5; //Step
Boolean sf=false; //save frame

void setup() {
  size(400, 400, P3D);
  colorMode(HSB );
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
  background(0);
  noStroke();
}

void draw() {
  background(0);
  pushMatrix();
  translate(-250, 0, -250);
  float h, h2=0;
  float t=sin(frameCount*0.01)*550;

  beginShape(TRIANGLE_STRIP);
  for (int z=0;z<=size;z+=s) { 


    h = noise(0, (z+t)*0.01);
    vertex(0, -h*200, z);
    for (int x=0;x<=size;x+=s) {
      h = noise(x*0.01, (z+t)*0.01);
      h2 = noise(x*0.01, (z+s+t)*0.01);
      fill((z/size)*255, 255, h*255);
      vertex(x, -h*200, z);
      fill(((z+s)/size)*255, 255, h2*255);
      vertex(x, -h2*200, z+s);
    }
    vertex(size, -h2*200, z+s);
  }
  endShape();

  if (axis) {
    stroke(255);
    line(-size, 0, 0, size, 0, 0);
    line(0, -size, 0, 0, size, 0);
    line(0, 0, -size, 0, 0, size);
    noStroke();
  }
  popMatrix();

  frame.setTitle(Float.toString(frameRate));
  if(frameCount%5==0 && frameCount*0.01<PI && sf) saveFrame("A####.png");
}

void keyReleased(){
  if(key=='a' || key=='A') axis=!axis;
  if(key=='s' || key=='S') sf=!sf;
}
