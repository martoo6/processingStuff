float detalle=0.1;
PShader shader;


void setup(){
  size(1400,700, P2D);
  background(0);
  colorMode(HSB);
  shader = loadShader("mask.glsl");
  fill(0);
}

void draw(){
  frame.setTitle(Integer.toString((int)(frameRate)));
  shader.set("time", (float) frameCount);
  shader(shader);
  rect(0,0,width,height);
}
