int cs[][]; //colors

void setup(){
  size(800,600);
  cs = new int[width][height];
  for(int y=1;y<height-1;y++){
    for(int x=1;x<width-1;x++){
      cs[x][y]=color(0);
    }
  }
}

void draw(){
  if(mousePressed) cs[constrain(mouseX,0,width-1)][constrain(mouseY,0,height-1)] = (int)color(random(0,255));
  for(int y=1;y<height-1;y++){
    for(int x=1;x<width-1;x++){
      //color c= (abs(cs[x+1][y]*cs[x-1][y])+abs(cs[x][y-1]*cs[x][y+1])>20000)?color(255)*100:color(0);
      
      int res = abs(cs[x+1][y]*cs[x-1][y])+abs(cs[x][y-1]*cs[x][y+1]);
      color c= (res>200)?cs[x][y]+10000:cs[x][y]-10000;
      
      //int res = abs(cs[x+1][y]*cs[x-1][y]*cs[x][y-1]*cs[x][y+1]);
      //color c= (res>2000)?cs[x][y]+10:cs[x][y];
      
     //color c = (cs[x][y]+cs[x-1][y-1]+cs[x+1][y+1]+cs[x-1][y+1]+cs[x+1][y-1])*10;
      
      set(x,y, c);
    }
  }
  for(int y=1;y<height-1;y++){
    for(int x=1;x<width-1;x++){
      cs[x][y]= get(x,y);
    }
  }
}
