int hs[][];

void setup(){
  size(700,700);
  background(0);
  hs=new int[width][height];
}

void draw(){
  for(int y=0;y<height;y++){
    for(int x=0;x<width;x++){
      //float calc=pow((x-width/2)*(y-height/2),0.9); //---> The fuck ?!?!? Just beautifull !
      //float calc=pow(abs((x-width/2)*(y-height/2)),0.9); //---> The fuck ?!?!? Just beautifull !
//      float calc=pow(abs((x-width/2)*(y-height/2))+frameCount,0.9); //---> The fuck ?!?!? Just beautifull !
      //float calc= abs((x*0.1-width/2)*(y*0.1-height/2))+frameCount;
      //float calc= (x-width/2)*(y-height/2)*0.2+frameCount;
      //float calc= sin(x)*cos(y)+frameCount*0.1; //SHADOW PATTERN
      float calc= tan(sin(x)*cos(y)+frameCount*0.1); //SHADOW PATTERN
      //float calc=log(abs((x-width/2)*(y-height/2))+frameCount)*100;
      //float calc=log(abs((x-width/2)*(y-height/2))+frameCount)*1000;
      //float calc=log(abs((x-width/2)*(y-height/2))+frameCount)*1000;
      //float e=PI/2;
      //for(float e=0;e<=PI;e+=PI/10) {
      //  calc+= pow(abs(sin(e)*(x-height/2)+cos(e)*(y-height/2))+sin(frameCount)*2, 0.1);
      //}
      color c = color(sin(calc)>0?255:0);
      set(x,y,c);
    }
  }
}
