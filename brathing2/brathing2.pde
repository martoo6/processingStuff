/* @pjs preload="face.jpg"; */

PImage img;
int s=600;//size

void setup() {
  size(400, 400, P3D);
  background(0);
  img = loadImage("face.jpg"); //hot chick always needed
  stroke(0, 200, 50); //matrix alike..yeah..
  noFill();
}

void draw() {
  background(0);
  stroke(255);
  pushMatrix();
  //translate(0,100,-500);
  translate(0,0,-500);
  //rotateX(-TWO_PI/4);
  line(-500,0,0,500,0,0);
  line(0,-500,0,0,500,0);
  line(0,0,-500,0,0,500);
  for (int z=0;z<s;z+=5) {
    int z1=(int)map(z,0,s,0,img.height);
    beginShape();
    for (int x=0;x<s;x+=5) {
      int x1=(int)map(x,0,s,0,img.width);
      float y1 = brightness(img.get(x1,z1))*0.3;
      float y = lerp(noise(x*0.01,z*0.01)*200,y1,abs(sin(frameCount*0.004)));
      stroke(0,200,50,y);
      vertex(x,y,z);
    }
    endShape();
  }
  popMatrix();
}
