int hs[][];

void setup(){
  size(800,600);
  background(0);
  hs=new int[width][height];
  for(int y=1;y<height-1;y++){
    for(int x=1;x<width-1;x++){
      hs[x][y]=(int)(noise(x*0.01,y*0.01)*255);      
    }
  }
}

void draw(){
  if(mousePressed) hs[mouseX][mouseY]=int(random(100,255));
  for(int y=1;y<height-1;y++){
    for(int x=1;x<width-1;x++){
//      int res = int(pow(hs[x-1][y]+hs[x+1][y]+hs[x][y-1]+hs[x][y+1],1.001)/3.8);
//int res = int(pow(hs[x-1][y]+hs[x+1][y]+hs[x][y-1]+hs[x][y+1],1)/4); // ugly blur fast...
      //int res = int(hs[x][y]+sin((hs[x+1][y]+hs[x-1][y])*0.0001)*1000); normal to noise
      //int res = int(hs[x][y]+tan((hs[x+1][y]+hs[x-1][y])*0.001)*tan((hs[x][y+1]+hs[x][y-1])*0.001)*10); //Like small circuit islands
//int res = int(hs[x][y]+sin((hs[x+1][y]+hs[x-1][y])*0.001)+cos((hs[x][y+1]+hs[x][y-1])*0.001)*10); //cos+sin is a circle ergo, we se cicles...=D yey !
int res = int(hs[x][y]-(1)*10); //like clamping
      color c = color(res);
      set(x,y,c);
    }
  }
  for(int y=1;y<height-1;y++){
    for(int x=1;x<width-1;x++){
      hs[x][y]=(int)brightness(get(x,y));
    }
  }
}
