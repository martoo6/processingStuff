int hs[][];



void setup() {
  size(800, 600);
  background(0);
  hs=new int[width][height];
}

void draw() {
  float multiplier = 1;
  float cant = 1;
  float a=1.001;
  
  
  float p = frameCount*0.1; //PHASE !
  for (int y=0;y<height;y++) {
    for (int x=0;x<height;x++) {
      //float calc = atan2(x,y)*10;
      float sum=0;
      for (float n=1;n<(cant+1)*multiplier;n+=multiplier) {
        float calc = (x*y*n*a)*0.01;
        sum += abs(cos(calc+p)+sin(calc+p))*0.5;
      }
      color c= color((int)(sum*255/cant));
      set(x, y, c);
    }
  }
}
