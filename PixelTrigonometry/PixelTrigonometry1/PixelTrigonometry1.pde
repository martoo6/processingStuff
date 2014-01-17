float detalle=0.1;
Cosine cosine= new Cosine();
Tang tang= new Tang();
Sine sine= new Sine();

void setup(){
  size(700,500);
  background(0);
  colorMode(HSB);
}

void draw(){
  frame.setTitle(Integer.toString((int)(frameRate)));
  float val1,val2,val3;
  loadPixels();
  float tam=mouseX*mouseY*0.0001;
  for(int i=0;i<width;i++){
    for(int e=0;e<height;e++){
      //val1=(sine.calc(e*detalle)*tang.calc(i*detalle)-cosine.calc(i*detalle)*tang.calc(e*detalle)+mouseX*0.1-mouseY*0.1)*255;
      //val1=(cosine.calc(e*0.1)*cosine.calc(i*0.1)-cosine.calc(frameCount*0.02))*255;
      //val1=150+tan(e*0.1)*tan(i*0.1)*tan(frameCount*0.02)*50;
      //val1=150+cosine.calc(e*0.1)*cosine.calc(i*0.1)*cosine.calc(frameCount*0.02)*50;
      //val1=150+(cosine.calc(e*0.1*tam)*cosine.calc(i*0.1*tam)+cosine.calc(frameCount*0.02))*50;
      //val1=150+(tan(e*0.1*tam)*tan(i*0.1*tam)+tan(frameCount*0.05)*tan(frameCount*0.02))*50;
      //val1=150+tan(e*i*0.05)*100*cosine.calc(frameCount*0.05);
      //val1=150+cosine.calc(e*i*0.05)*100*cosine.calc(frameCount*0.02);
      val1=100+(tang.calc(e*0.02)*cosine.calc(i*0.2)*50+tang.calc(i*0.02)*cosine.calc(e*0.2)*50)*cosine.calc(frameCount*0.1);
      //val1=100+(tang.calc(i*0.02)*cosine.calc(i*0.2)*50+tang.calc(e*0.02)*cosine.calc(e*0.2)*50)*noise(frameCount*0.1);
      pixels[e*width+i]=color(val1,255,255);
    }
  }
  updatePixels();
}

class Cosine{
  float []vals = new float[360*1000];
  float step= TWO_PI/vals.length;
  Cosine(){
    for(int i=0;i<vals.length;i++){
      vals[i]=cos(step*i);
    }
  }
  public float calc(float val){
    if(val>=TWO_PI){
      val-=TWO_PI*floor(val/TWO_PI);
      if(val>TWO_PI) val=TWO_PI;
    }
    return vals[floor(map(val,0,TWO_PI, 0, vals.length-1))];
  }
}

class Sine{
  float []vals = new float[360*4];
  float step= TWO_PI/vals.length;
  Sine(){
    for(int i=0;i<vals.length;i++){
      vals[i]=sin(step*i);
    }
  }
  public float calc(float val){
    if(val>=TWO_PI){
      val-=TWO_PI*floor(val/TWO_PI);
      if(val>TWO_PI) val=TWO_PI;
    }
    return vals[floor(map(val,0,TWO_PI, 0, vals.length-1))];
  }
}

class Tang{
  float []vals = new float[360*4];
  float step= TWO_PI/vals.length;
  Tang(){
    for(int i=0;i<vals.length;i++){
      vals[i]=tan(step*i);
    }
  }
  public float calc(float val){
    if(val>=TWO_PI){
      val-=TWO_PI*floor(val/TWO_PI);
      if(val>TWO_PI) val=TWO_PI;
    }
    return vals[floor(map(val,0,TWO_PI, 0, vals.length-1))];
  }
}
