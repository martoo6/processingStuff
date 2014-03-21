int hs[][];

void setup(){
  size(800,600);
  background(0);
  hs=new int[width][height];
}

void draw(){
  float a=255; //Amplitude
  float p=1; //Phase 
  float f=1.01; //Frequency
  float aa=0.1;
  
  
  for(int y=0;y<height;y++){
    for(int x=0;x<width;x++){
      float calc = new tDist3().setPhase(frameCount)
                                .setFreq(770)
                                .calc(x,y)*1E6;
      color c = (int)calc;
      set(x,y,c);
    }
  }
}


abstract class trigFunc{
  float p=1;//Phase
  float f=1;//Frequency
  
  abstract float calc(float x, float y);
  trigFunc setPhase(float p){
    this.p=p;
    return this;
  }
  
  trigFunc setFreq(float f){
    this.f=f;
    return this;
  }
}

class tSinX extends trigFunc{
  float calc(float x, float y){
      return sin(x*f+p);
  }
}

class tSinY extends trigFunc{
  float calc(float x, float y){
      return sin(y*f+p);
  }
}

class tSinXxY extends trigFunc{
  float calc(float x, float y){
      return sin(x*y*f+p);
  }
}

class tSinXpY extends trigFunc{
  float calc(float x, float y){
      return sin((x+y)*f+p);
  }
}

class tCirc2 extends trigFunc{
  float calc(float x, float y){
      return cos(x*f+p)*sin(y*f+p);
  }
}

class tCirc extends trigFunc{
  float calc(float x, float y){
      return cos(x*f+p)+sin(y*f+p);
  }
}

class tDiag1 extends trigFunc{
  float calc(float x, float y){
      return sin((x+y)*f+p);
  }
}

class tDiag2 extends trigFunc{
  float calc(float x, float y){
      return sin((x-y)*f+p);
  }
}

class tDiag3 extends trigFunc{
  float calc(float x, float y){
      return x>=width/2?sin((x+y)*f+p):sin((x-y)*f+p);
  }
}

class tDist4 extends trigFunc{
  float calc(float x, float y){
      return sin(abs(width/2-x)*f+abs(height/2-y)*f+p);
  }
}

class tDist2 extends trigFunc{
  float calc(float x, float y){
      return sin((pow(width/2-x,2)+pow(height/2-y,2))*f+p); //Distance not euclidian, ergo..higher frequency when gatting away from center...
  }
}

class tDist3 extends trigFunc{
  float calc(float x, float y){
      return sin(sqrt((pow(width/2-x,2)+pow(height/2-y,2))*f)+p); //Perfect circle
  }
}

class tSinc2 extends trigFunc{
  float calc(float x, float y){
      return sin(x*f+p)+sin(y*f+p);
  }
}
