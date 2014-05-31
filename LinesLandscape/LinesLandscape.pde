void setup() {
  size(500, 500, P3D);
  background(0);
  stroke(0, 200, 50);
  noFill();
}

void draw() {
  background(0);
  translate(0,200,-500);
  rotateX(-TWO_PI/10);
  for (int z=0;z<500;z+=10) {
    beginShape( );
    for (int x=0;x<500;x+=10) {
      curveVertex(x,noise(x*0.01,z*0.01)*100,z);
    }
    endShape();
  }
}
