int step = 1;
int maxPoints = 200;
noise noiser;

void setup()
{
  size(maxPoints*step, maxPoints*step);
  noStroke();

  noiser = new noise(new cubic()).setContrast(0.55);

  int cant=0;
}

void draw() {
  for (float i = 0; i < maxPoints-1; i++) {
    for (float e = 0; e < maxPoints-1; e++) {
      //fill(noiser.getCompoundValue(i*0.05, e*0.05)*255);
      fill(noiser.getSimpleValue(i*0.05, e*0.05)*255);
      rect(i*step, e*step, step, step);
    }
  }
}

private interface interpolation
{
  float getValue(float x, ArrayList values);
  float getValue(float x, float y, ArrayList values);
}

private class linear implements interpolation {
  public float getInterpolation(float y1, float y2, float x) {
    return (y2-y1)*x+y1;
  }
  public float getValue(float x, ArrayList values) {
    int xF = floor(x);
    while (xF+2>values.size ()) {
      values.add(random(1));
    }
    return getInterpolation((Float)values.get(xF), (Float)values.get(xF+1), x-xF);
  }
  public float getValue(float x, float y, ArrayList values) {
    int yF = floor(y);
    while (yF+2>values.size ()) {
      values.add(new ArrayList());
    }
    float val1=getValue(x, (ArrayList)values.get(yF));
    float val2=getValue(x, (ArrayList)values.get(yF+1));
    return getInterpolation(val1, val2, y-yF);
  }
}


private class cubic implements interpolation
{
  public float getInterpolation(float y1, float y2, float y3, float y4, float x) {
    return (-0.5 *y1 + 1.5*y2 - 1.5*y3 + 0.5*y4)*pow(x, 3)+(y1-2.5*y2+2*y3-0.5*y4)*pow(x, 2) +(-0.5*y1+0.5*y3)*x+y2;
  }
  public float getValue(float x, ArrayList values)
  {
    int xF = floor(x);
    while (xF+8>values.size ()) {
      values.add(random(1));
    }
    return getInterpolation((Float)values.get(xF), (Float)values.get(xF+1), (Float)values.get(xF+2), (Float)values.get(xF+3), x-xF);
  }
  public float getValue(float x, float y, ArrayList values)
  {
    int yF = floor(y);

    while (yF+8>values.size ()) {
      values.add(new ArrayList());
    }
    float val1=getValue(x, (ArrayList)values.get(yF));
    float val2=getValue(x, (ArrayList)values.get(yF+1));
    float val3=getValue(x, (ArrayList)values.get(yF+2));
    float val4=getValue(x, (ArrayList)values.get(yF+3));

    float result = getInterpolation(val1, val2, val3, val4, y-yF);
    return result;
  }
}

private class noise {
  ArrayList values=new ArrayList();
  interpolation type;
  
  //Compound Value parameters 
  int detail=4;
  float contrast=0.55;
  
  public noise setInterpolation(interpolation type) {
    this.type=type;
    return this;
  }
  
  public noise setDetail(int detail){
    this.detail=detail;
    return this;
  }
  
  public noise setContrast(float contrast){
    this.contrast=contrast;
    return this;
  }
  
  public noise(interpolation type) {
    this.type = type;
  }

  public float getSimpleValue(float x) {
    return type.getValue(x, (ArrayList)((ArrayList)values.get(0)).get(0));
  }
  public float getSimpleValue(float x, float y) {
    return type.getValue(x, y, (ArrayList)values.get(0));
  }
  public float getCompoundValue(float x) {
    float total=0;
    int freq=1;
    float amp=contrast;
    for (int i=0;i<detail;i++) {
      total+=this.getSimpleValue(x*freq)*amp;
      freq*=2;//Siempre duplicamos la frecuencia, equivalente a cambiar de octava
      amp*=contrast;
    }
    return total;
  }
  public float getCompoundValue(float x, float y) {
    float total=0;
    int freq=1;
    float amp=contrast;
    for (int i=0;i<detail;i++) {
      total+=this.getSimpleValue(x*freq, y*freq)*amp;
      freq*=2;//Siempre duplicamos la frecuencia, equivalente a cambiar de octava
      amp*=contrast;
    }
    return total;
  }
}
