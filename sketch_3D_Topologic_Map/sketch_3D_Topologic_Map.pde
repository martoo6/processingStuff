import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

float m[][];
float yStep=0.04;
float blobSize=0.01;
PeasyCam cam;
int s=300;
int sSize=2;

void setup() {
  size(500, 500, P3D);
  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(1);
  cam.setMaximumDistance(1500);
  m = new float[s*2][s*2];
  noStroke();
  
  
  for (int x=-s;x<s;x++) {
      for (int z=-s;z<s;z++) {
        m[x+s][z+s]=noise(x*0.01+4096, z*0.01+4096);
      }
    }
  
}

void draw() {
  background(0 ); 
  //rotateX(-TWO_PI/8);
    //color c = color(noise(y*8)*255, 0, noise(y*8+50)*255);
    for (int x=-s;x<s;x++) {
      for (int z=-s;z<s;z++) {
        for (float y=0;y<1;y+=yStep) {
          if (abs(m[x+s][z+s]-y)<=blobSize) {
            fill(color(noise(y*8)*255, 0, noise(y*8+50)*255));
            //point(x, -y*400,z);
            pushMatrix();
            translate(x*sSize, -y*400, z*sSize);
            rotateX(-PI/2);
            rect(0,0, sSize,sSize);
            popMatrix();
          }
        }
        //m[x+s][z+s]=noise(x*0.01+4096, z*0.01+4096, frameCount*0.01);
      }
    }
}

void keyPressed(){
  if(key=='q') yStep+=0.001;
  if(key=='a') if(yStep>0.001) yStep-=0.001;
  if(key=='w') blobSize+=0.001;
  if(key=='s') if(blobSize>0.001) blobSize-=0.001;
}
