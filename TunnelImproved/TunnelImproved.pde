Fmath fMath = new Fmath();
final float step = PI/16;
final float stepZ = 50;
final int r = 200; //Radius

void setup() {
  size(500, 500, P3D);
  colorMode(HSB );
  background(0 );
  noStroke();
}

void draw() {
  background(0);
  translate(width/2, height/2, 0);
  for(int i=-1000;i<250;i+=stepZ) {
    float x1 = sin(i*0.01+frameCount*0.1)*50;
    float x2 = sin((i+stepZ)*0.01+frameCount*0.1)*50;
    drawStripe(x1,x2,i, stepZ);
  }
  if(frameCount*0.1<TWO_PI) saveFrame("a####.png" );
  //text(frameRate,0,0);
}

void drawStripe(float x1, float x2,float z, float w/*width*/) {
  int c = 100;
  beginShape(TRIANGLE_STRIP);
  pushMatrix();
  translate(0, 0, z);
  for (float i=0;i<TWO_PI; i+=step) {
    float x = fMath.cosine(i)*r;
    float y = fMath.sine(i)*r;
    x+=x1;
    fill(c,255,map(z,-1000,200,0,255));//Per vertex color dude !
    vertex(x, y, 0);
    x = fMath.cosine(i)*r;
    y = fMath.sine(i)*r;
    x+=x2;
    fill(c,255,map(z+w,-1000,200,0,255));
    vertex(x, y, w);
    x = fMath.cosine(i+step)*r;
    y = fMath.sine(i+step)*r;
    x+=x1;
    fill(c,255,map(z,-1000,200,0,255));
    vertex(x, y, 0);
    x = fMath.cosine(i+step)*r;
    y = fMath.sine(i+step)*r;
    x+=x2;
    fill(c,255,map(z+w,-1000,200,0,255));
    vertex(x, y, w);
    endShape();
  }
  popMatrix();
}

class Fmath{
  int cant = 360;
  float []cosineVals = new float[cant];
  float []sineVals = new float[cant];
  float []tangVals = new float[cant];
  float step= TWO_PI/cant;
  
  public Fmath(){
    for(int i=0;i<cant;i++){
      cosineVals[i]=cos(step*i);
      sineVals[i]=sin(step*i);
      tangVals[i]=tan(step*i);
    }
  }
  
  private int rightAngle(float val){
    if(val>=TWO_PI){
      val-=TWO_PI*floor(val/TWO_PI);
      if(val>TWO_PI) val=TWO_PI;
    }
    return floor(map(val,0,TWO_PI, 0, cant-1));
  }
  
  public float cosine(float val){
    return cosineVals[rightAngle(val)];
  }
  public float sine(float val){
    return sineVals[rightAngle(val)];
  }
  public float tang(float val){
    return tangVals[rightAngle(val)];
  }
}
