// Using brightness of image to map for position

import java.util.*;

PImage img;
int s = 5;
ArrayList<Fragment> fragments; 
int setEnd;
int setStart;

void setup(){
  img = loadImage("tape-face-2.jpg");
  size(img.width,img.height);
  noLoop();
  fragments = new ArrayList<Fragment>();

  for(int x=0;x<img.width;x+=s){
    for(int y=0;y<img.height;y+=s){
      fragments.add(new Fragment(new PVector(x,y)));
    }
  }
  
  Comparator<Fragment> c = new Comparator<Fragment>() {
    public int compare(Fragment f1, Fragment f2) {
        return f2.brightness - f1.brightness; // use your logic
    }
  };
  
  Collections.sort(fragments, c);
}



void draw(){
  for(int x=0;x<img.width;x+=s){
    for(int y=0;y<img.height;y+=s){
      Fragment f = fragments.get((int)(noise(x*0.001, y*0.001)*fragments.size()));
      copy(img, (int)f.pos.x, (int)f.pos.y, s, s, x, y, s, s);
    }
  } 
}

class Fragment{
  
  int brightness;
  PVector pos;
  
  Fragment(PVector pos){
    this.pos = pos;
    long total=0;
    for(int x=(int)pos.x;x<(int)pos.x+s;x++) for(int y=(int)pos.y;y<(int)pos.y+s;y++) total += brightness(img.get((int)pos.x, (int)pos.y));
    brightness=(int)(total/(s*s));
  }
}
