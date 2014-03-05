int cs[][]; //colors

void setup(){
  size(400,400);
  cs = new int[width][height];
}

void draw(){
  if(mousePressed) cs[constrain(mouseX,0,width-1)][constrain(mouseY,0,height-1)] = (int)random(255);
  for(int y=1;y<height-1;y++){
    for(int x=1;x<width-1;x++){
      //color c= color(pow(cs[x-1][y-1],2),pow(cs[x-1][y+1]*cs[x-1][y+1],2),pow(cs[x+1][y+1]-cs[x][y+1],2));
      //color c= color(pow(cs[x-1][y-1]*cs[x][y-1],2),pow(cs[x+1][y-1]*cs[x-1][y],2),pow(cs[x][y]*cs[x+1][y],2));
      //color c= color(pow(cs[x][y-1]*cs[x-1][y],1.2),pow(cs[x][y+1]*cs[x+1][y],1.2),pow(cs[x][y]-cs[x-1][y+1],1.2));
      //color c= color(pow(cs[x][y-1]-cs[x-1][y],-1.2),pow(cs[x][y+1]*cs[x+1][y],1.2),pow(cs[x][y]-cs[x-1][y+1],3.2));
      //color c= color(pow(cs[x][y-1]-cs[x-1][y]*cs[x][y+1]-cs[x+1][y],3.2), pow(cs[x][y-1]+cs[x-1][y]*cs[x][y+1]+cs[x+1][y],3.2), pow(cs[x][y-1]*cs[x-1][y]-cs[x][y+1]*cs[x+1][y],3.2));
      //color c= color(pow(cs[x][y]-cs[x+1][y],-3.2), pow(cs[x][y-1]+cs[x-1][y]*cs[x][y+1]+cs[x+1][y],-3.2), pow(cs[x-1][y]-cs[x][y+1]*cs[x+1][y],3.2));
      color c= color(pow(cs[x][y]-cs[x+1][y],3.2), pow(cs[x][y-1]*cs[x+1][y],3.2), pow(cs[x-1][y]-cs[x][y+1],3.2));
      set(x,y, c);
      cs[x][y]= c;
    }
  }
}
