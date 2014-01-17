//
//
//
//----TODO: GENERADOR DE EXPRESIONES REGULARES PARA PODER MOSTRAR DISTINTAS FUNCIONES MATEMATICAS EN FORMA SUPER LOCA---------
//
//
//
int initValue = (int)random(0,255);
Fmath fMath = new Fmath(); 

void setup(){
  size(700,500);
  background(0);
  colorMode(HSB);
}

void draw(){
  frame.setTitle(Integer.toString((int)(frameRate)));
  float val1,val2,val3;
  loadPixels();
  for(int i=0;i<width;i++){
    for(int e=0;e<height;e++){
      val1=initValue;
      pixels[e*width+i]=color(val1,255,255);
    }
  }
  updatePixels();
}

class Fmath{
  int cant = 360*100;
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
