import peasy.*;

PeasyCam cam;


void setup() {
  size(500, 500, P3D);
  colorMode(HSB );
    cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
  background(0);
  noFill();
  stroke(255);
}

void draw() {
  background(0);
  translate(-250,0,-250);
  float h;
  float t=frameCount*0.01;
  for (int z=0;z<500;z+=5) {
    beginShape();
    for (int x=0;x<500;x+=10) {
      //h = noise(x*0.01, z*0.01,t);
      h = noise(x*0.01, z*0.01+t);
      stroke((z/500.0)*255,255,h*255);
      curveVertex(x, -h*200, z);
    }
    endShape();
  }
}
