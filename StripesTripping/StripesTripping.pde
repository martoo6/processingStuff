int hs[][];

void setup(){
  size(500,500);
  background(0);
  hs=new int[width][height];
}

void draw(){
  for(int y=0;y<height;y++){
    for(int x=0;x<width;x++){
      //float calc = cos((x+y)*0.5+frameCount*0.5)>=0?255:0;
      float calc2 = sin((abs(width/2-x)+abs(height/2-y))*0.5-frameCount);
      float calc = calc2>0?255:0;
      color c = color(calc);
      set(x,y,c);
    }
  }
  translate(width/2,height/2);
  noFill();
  for(int y=0;y<height/2;y++){
    if(cos(y*0.5+frameCount*0.5)>=0) stroke(255); else noStroke();
    //stroke((y+frameCount)%20>10?255:0);
    ellipse(0,0,y,y);
  }
  if(frameCount<=TWO_PI*2) saveFrame("#####.png"); 
}
