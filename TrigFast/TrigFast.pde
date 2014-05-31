int hs[][];

void setup(){
  size(400,400);
  background(0);
  hs=new int[width][height];
}

void draw(){
  for(int y=0;y<height;y++){
    for(int x=0;x<height;x++){
      float calc=0;
      for(float n=0;n<TWO_PI;n+=(PI/5)){
        calc=sin(x+y*cos(n)+frameCount*0.1);
      }
      calc=(calc*128+128);
      color c= color((int)calc);
       set(x,y,c); 
    }
  }
}
