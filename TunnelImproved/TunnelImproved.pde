Fmath fMath = new Fmath();
final float step = PI/32;
final float stepZ = 5;

void setup() {
  size(500, 500, P3D);
  background(0 );
  noStroke();
}

void draw() {
  background(0);
  //lights();
  translate(width/2, height/2, 0);
  for(int i=-1000;i<250;i+=stepZ) {
    fill(map(i,-600,200,0,255));
    float x1 = sin(i*0.01+frameCount*0.1)*50;
    float x2 = sin((i+stepZ)*0.01+frameCount*0.1)*50;
    drawStripe(x1,x2,i, stepZ);
  }
  saveFrame("###.png" );
  //text(frameRate,0,0);
}

void drawStripe(float x1, float x2,float z, float w/*width*/) {
  beginShape(TRIANGLE_STRIP);
  pushMatrix();
  translate(0, 0, z);
  for (float i=0;i<TWO_PI; i+=step) {
    float x = fMath.cosine(i)*200;
    float y = fMath.sine(i)*200;
    x+=x1;
    vertex(x, y, 0);
    x = fMath.cosine(i)*200;
    y = fMath.sine(i)*200;
    x+=x2;
    vertex(x, y, w);
    x = fMath.cosine(i+step)*200;
    y = fMath.sine(i+step)*200;
    x+=x1;
    vertex(x, y, 0);
    x = fMath.cosine(i+step)*200;
    y = fMath.sine(i+step)*200;
    x+=x2;
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
