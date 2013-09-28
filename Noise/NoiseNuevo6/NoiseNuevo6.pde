int step = 1;
int maxPoints = 500;
int []detail1 = {5,5,5};
noise noiser;

void setup()
{
  size(maxPoints*step, maxPoints*step);
  noStroke();
  noiser = new noise(detail1,new linear());  
  //noiser = new noise(detail1, new cubic());  
  int cant=0;
}

void draw() {
  frame.setTitle(Integer.toString((int)(frameRate)));
  for (float i = 0; i < maxPoints-1; i++) {
    for (float e = 0; e < maxPoints-1; e++) {
      //fill(noiser.getValue(i*0.05+time, e*0.05, frameCount*0.05)*255);//Interesantisimo notar como si multiplico por 0.5 al ser una operacion de shift aumentan los fps !!!
      float val=noiser.getValue(i*0.05, e*0.05, frameCount*0.05)*255;
      //float val = noiser.getCompoundValue(i*0.05+time, e*0.05, frameCount*0.05)*255;
        //fill(val);
      
      //rect(i*step, e*step, step, step);
    }
  }
}

private interface interpolation
{
  float getValue(float x, float[] values);
  float getValue(float x, float y, float[][] values);
  float getValue(float x, float y, float z, float[][][] values);
}

private class linear implements interpolation {
  public float getValue(float x, float[] values) {
    int xF = floor(x);
    return linearInterpolation(values[xF], values[xF+1], x-xF);
  }
  public float getValue(float x, float y, float[][] values) {
    int yF = floor(y);
    float val1=getValue(x,values[yF]);
    float val2=getValue(x,values[yF+1]);
    return linearInterpolation(val1, val2, y-yF);
  }
  public float getValue(float x, float y, float z, float[][][] values) {
    int zF = floor(z);
    float val1=getValue(x, y, values[zF]);
    float val2=getValue(x, y, values[zF+1]);
    return linearInterpolation(val1, val2, z-zF);
  }
}

private float linearInterpolation(float y1, float y2, float x) {
  return (y2-y1)*x+y1;
}
private float cubicInterpolation(float y1, float y2, float y3, float y4, float x) {
  return 0.5*(3*(y2 - y3) + y4 -y1)*pow(x, 3)+(y1-2.5*y2+2*y3-0.5*y4)*pow(x, 2) +0.5*(y3-y1)*x+y2;
}

private class cubic implements interpolation
{
  public float getValue(float x, float[] values)
  {
    int xF = floor(x);

    return cubicInterpolation(values[xF-1], values[xF], values[xF+1], values[xF+2], x-xF);
  }
  public float getValue(float x, float y, float[][] values)
  {
    int yF = floor(y);
    
    float val1=getValue(x,values[yF-1]);
    float val2=getValue(x,values[yF]);
    float val3=getValue(x,values[yF+1]);
    float val4=getValue(x,values[yF+2]);
    
    return cubicInterpolation(val1, val2, val3, val4, y-yF);
  }
  
  public float getValue(float x, float y, float z, float[][][] values)
  {
    int zF = floor(z);
    
    float val1=getValue(x,y,values[zF-1]);
    float val2=getValue(x,y,values[zF]);
    float val3=getValue(x,y,values[zF+1]);
    float val4=getValue(x,y,values[zF+2]);
    
    return cubicInterpolation(val1, val2, val3, val4, z-zF);
  }
}

private class noise {
  float[][][] values;
  interpolation type;
  
  int detailCompound=6;
  float contrast=0.55;
  int []detail;

  public noise(int []detail, interpolation type) {
    this.detail=detail;
    values = new float[detail[2]+3][detail[1]+3][detail[0]+3]; //Sumo 3 valores mas para poder calcular cubicas.
    for (int i = 0; i < detail[2]+3; i++) {
      for (int e = 0; e < detail[1]+3; e++) {
        for (int j = 0; j < detail[0]+3; j++) {
          int val1=i;
          int val2=e;
          int val3=j;
          boolean flag=false;
          if(j>=detail[0]){
            val3-=detail[0];
            flag=true;
          }
          if(e>=detail[1]){
            val2-=detail[1];
            flag=true;
          }
          if(i>=detail[2]){
            val1-=detail[2];
            flag=true;
          }
          if(flag){
            values[i][e][j] =  values[val1][val2][val3];
          }else{
            values[i][e][j] = random(1);
          }
        }
      }
    }
    this.type = type;
  }

  public noise setContrast(float contrast){
    this.contrast=contrast;
    return this;
  }

  public float getValue(float x) {
    if(x>=detail[0]){
      x-=detail[0]*floor(x/detail[0]);
    }
    x++;
    return type.getValue(x, values[0][0]);
  }
  public float getValue(float x, float y) {
    if(x>=detail[0]){
      x-=detail[0]*floor(x/detail[0]);
    }
    if(y>=detail[1]){
      y-=detail[1]*floor(y/detail[1]);
    }
    x++;
    y++;
    return type.getValue(x, y, values[0]);
  }
  public float getValue(float x, float y, float z) {
    if(x>=detail[0]){
      x-=detail[0]*floor(x/detail[0]);
    }
    if(y>=detail[1]){
      y-=detail[1]*floor(y/detail[1]);
    }
    if(z>=detail[2]){
      z-=detail[2]*floor(z/detail[2]);
    }
    x++;
    y++;
    z++;
    return type.getValue(x, y, z, values);
  }
  
  public float getCompoundValue(float x) {
    float total=0;
    int freq=1;
    float amp=contrast;
    for (int i=0;i<detailCompound;i++) {
      total+=this.getValue(x*freq)*amp;
      freq*=2;//Siempre duplicamos la frecuencia, equivalente a cambiar de octava
      amp*=contrast;
    }
    return total;
  }
  public float getCompoundValue(float x, float y) {
    float total=0;
    int freq=1;
    float amp=contrast;
    for (int i=0;i<detailCompound;i++) {
      total+=this.getValue(x*freq, y*freq)*amp;
      freq*=2;//Siempre duplicamos la frecuencia, equivalente a cambiar de octava
      amp*=contrast;
    }
    return total;
  }
  public float getCompoundValue(float x, float y, float z) {
    float total=0;
    int freq=1;
    float amp=contrast;
    for (int i=0;i<detailCompound;i++) {
      total+=this.getValue(x*freq, y*freq, z*freq)*amp;
      freq*=2;//Siempre duplicamos la frecuencia, equivalente a cambiar de octava
      amp*=contrast;
    }
    return total;
  }
}

