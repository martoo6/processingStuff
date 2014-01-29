PShader shader;


void setup(){
  size(1280,720, P2D);
  shader = loadShader("mask.glsl");
}

void draw(){
  frame.setTitle(Integer.toString((int)(frameRate)));
  shader.set("time", (float) frameCount);
  shader.set("detail", (int)map(mouseX, 0, width, 0, 255));
  shader(shader);
  rect(0,0,width,height);
}

void keyPressed()
{
  setup();
}
