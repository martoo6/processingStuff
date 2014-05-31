/* @pjs preload="face.jpg"; */

PImage img;
int s=500;//size

void setup() {
  size(500, 500, P3D);
  background(0);
  img = loadImage("face.jpg"); //hot chick always needed
  stroke(0, 200, 50); //matrix alike..yeah..
  noFill();
}

void draw() {
  background(0);
  translate(0,100,-600);
  rotateX(-TWO_PI/8);
  for (int z=0;z<s;z+=10) {
    int z1=(int)map(z,0,s,0,img.height);
    beginShape();
    for (int x=0;x<s;x+=20) {
      int x1=(int)map(x,0,s,0,img.width);
      float y1 = pow(brightness(img.get(x1,z1)),1.1)*0.3;
      float y = lerp(noise(x*0.01,z*0.01)*200,-y1,abs(sin(frameCount*0.04)));
      
      curveVertex(x,y,z);
    }
    endShape();
  }
}
