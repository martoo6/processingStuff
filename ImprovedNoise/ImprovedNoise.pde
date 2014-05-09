int step = 1;
int maxPoints = 500;
noise noiser;

void setup()
{
  size(maxPoints*step, maxPoints*step);
  noStroke();
  noiser = new noise(new linear(), 1, 1);  
  int cant=0;
}

void draw() {
  frame.setTitle(Integer.toString((int)(frameRate)));
  for (float i = 0; i < maxPoints-1; i++) {
    for (float e = 0; e < maxPoints-1; e++) {
      //fill(noiser.getValue(i*0.05+time, e*0.05, frameCount*0.05)*255);//Interesantisimo notar como si multiplico por 0.5 al ser una operacion de shift aumentan los fps !!!
      //float val=noiser.getValue(i*0.05, e*0.05, frameCount*0.05)*255;
      //float val = noiser.getCompoundValue(i*0.05, e*0.05, frameCount*0.05)*255;
      //fill(val);

      rect(i*step, e*step, step, step);
    }
  }
}

private interface interpolation
{
  float getValue(float x, float[] values);
}

private class linear implements interpolation {
  public float getValue(float x, float[] values) {
    int xF = floor(x);
    return linearInterpolation(values[xF], values[xF+1], x-xF);
  }
}

private float linearInterpolation(float y1, float y2, float x) {
  return (y2-y1)*x+y1;
}


private class noise {
  float[] values;
  interpolation type;

  int detailCompound=6;
  float contrast=0.55;
  int totalSize;
  
  int[] details;

  public noise(interpolation type, int ...details ) {
    this.details = details;
    totalSize=1;  
    for (int e=0;e<details.length;e++) {
      details[e]+=3;
      totalSize*=details[e];//Sumo 3 valores mas para poder calcular cubicas.
    }

    println("Amount of dimensions: " + details.length);
    println("Total Size: " + totalSize);

    values = new float[totalSize];

    for (int e=0;e<totalSize;e++) {
      //values[e]=e;
      values[e]=random(1);
    }

    //x+(xSize*y)+(xSize*ySize*z)+(xSize*ySize*zSize*w)....

    for (int i=0;i<values.length; i++) println(values[i]);
    println("________________________________");
    for (int i=0;i<4; i++) for (int e=0;e<4; e++) println(getValue(e,i));
    this.type = type;
  }

  public noise setContrast(float contrast) {
    this.contrast=contrast;
    return this;
  }

  //public float getValue(float ... args) {
  public float getValue(int ... args) {
    //Cuenta Fea
    int pos=0;
    for (int i=0;i<args.length; i++) {
      int tot=args[i];
      for(int e=0;e<i;e++) tot*=details[i];
      pos+=tot;
    }
    
    return values[pos];
    //for (int e=0;e<args.length;e++)  args[e]-=detail[e]*floor(x/detail[e])+1;
    //return type.getValue(args);
  }
}

/*public float getCompoundValue(float ... args) {
 float total=0;
 int freq=1;
 float amp=contrast;
 for (int i=0;i<detailCompound;i++) {
 for(int e=0;e<args.length;e++) args[e]*=freq;
 total+=this.getValue(args)*amp;
 freq*=2;//Siempre duplicamos la frecuencia, equivalente a cambiar de octava
 amp*=contrast;
 }
 return total;
 }*/
