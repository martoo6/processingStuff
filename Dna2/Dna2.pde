import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

float r = 100; //Radius
float f=0.01;
float dist=0;

PeasyCam cam;



void setup() {
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 500);
  cam.setMaximumDistance(5000 );
  cam.setMinimumDistance(50);
  background(0);
  FMath.init(360);
}

void draw() {
  background(0);

  getDna(1, 255);
}

void getDna(float h, int opacity) {

  dist = (float)cam.getDistance();

  lights();

  noStroke();
  fill(color(100, 100, 255));


  pushMatrix();
  translate(-dist/2, 0);
  rotateX(frameCount*0.01);

  sphereDetail(round(map(dist, 10, 2000, 15, 1)));
  float rr=20;
  for (int i=0;i<8;i++)  renderHelix(0, noise(i, frameCount*0.01)*rr-rr/2, noise(i+10, frameCount*0.01)*rr, noise(i+15, frameCount*0.01)*rr);
  //Second helix which phase + PI
  for (int i=0;i<8;i++)  renderHelix(PI, noise(i, frameCount*0.01)*rr-rr/2, noise(i+10, frameCount*0.01)*rr, noise(i+15, frameCount*0.01)*rr);

  fill(color(150, 150, 255));
  sphereDetail(round(map(dist, 10, 600, 15, 1)));
  for (float x=0;x<dist;x+=TWO_PI*4) {
    float y= FMath.sine(x*f)*r;
    float z= FMath.cosine(x*f)*r;
    float y2= FMath.sine(x*f+PI)*r;
    float z2= FMath.cosine(x*f+PI)*r;
    for (float i=0;i<1;i+=0.1) {
      float ySphere = lerp(y, y2, i);
      float zSphere = lerp(z, z2, i);
      pushMatrix();
      translate(x, ySphere, zSphere);
      sphere(2);
      popMatrix();
    }
  }

  popMatrix();

  frame.setTitle(int(frameRate) + " fps");
}

void renderHelix(float phase, float randomnessX, float randomnessY, float randomnessZ) {
  for (float x=0;x<dist;x+=TWO_PI*4) {
    float y= FMath.sine(x*f+phase)*(r+randomnessY);
    float z= FMath.cosine(x*f+phase)*(r+randomnessZ);
    pushMatrix();
    translate(x+randomnessX, y, z);
    sphere(6);
    popMatrix();
  }
}
