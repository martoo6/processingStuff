float detalle=0.1;
Fmath fMath = new Fmath(); 

void setup(){
  size(1400,700);
  background(0);
  colorMode(HSB);
}

void draw(){
  frame.setTitle(Integer.toString((int)(frameRate)));
  float val1,val2,val3;
  loadPixels();
  float tam=mouseX*mouseY*0.0001;
  for(int i=0;i<width;i++){
    float a = fMath.cosine(i*0.2)*50;
    float b =fMath.tang(i*0.02);
    for(int e=0;e<height;e++){
      //val1=(fMath.sine(e*detalle)*fMath.tang(i*detalle)-fMath.cosine(i*detalle)*fMath.tang(e*detalle)+mouseX*0.1-mouseY*0.1)*255;
      //val1=(fMath.cosine(e*0.1)*fMath.cosine(i*0.1)-fMath.cosine(frameCount*0.02))*255;
      //val1=150+tan(e*0.1)*tan(i*0.1)*tan(frameCount*0.02)*50;
      //val1=150+fMath.cosine(e*0.1)*fMath.cosine(i*0.1)*fMath.cosine(frameCount*0.02)*50;
      //val1=150+(fMath.cosine(e*0.1*tam)*fMath.cosine(i*0.1*tam)+fMath.cosine(frameCount*0.02))*50;
      //val2=150+(tan(e*0.1*tam)*tan(i*0.1*tam)+tan(frameCount*0.05)*tan(frameCount*0.02))*50;
      //val2=150+tan(e*i*0.05)*100*fMath.cosine(frameCount*0.05);
      //val1=150+fMath.cosine(e*i*0.05)*100*fMath.cosine(frameCount*0.02);
      val1=100+(fMath.tang(e*0.02)*a+b*fMath.cosine(e*0.2)*50)*fMath.cosine(frameCount*0.1);
      //val1=100+(fMath.tang(i*0.02)*fMath.cosine(i*0.2)*50+fMath.tang(e*0.02)*fMath.cosine(e*0.2)*50)*noise(frameCount*0.1);
      pixels[e*width+i]=color(val1,255,255);
    }
  }
  updatePixels();
}

class Fmath{
  int cant = 360*10;
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
    //val= val%TWO_PI; //Ineficiente vaya uno a saber porque...
    val-=TWO_PI*floor(val/TWO_PI);
    return floor((val/TWO_PI)*cant);
    //return floor(map(val,0,TWO_PI, 0, cant-1));
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
