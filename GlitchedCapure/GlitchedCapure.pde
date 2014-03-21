import processing.video.*;


Capture video;
int hs[][];

void setup() {
  video = new Capture(this, 1280, 720);
  size(1280, 720);
  background(0);
  hs=new int[width][height];
  video.start();
}

void draw() {
  if (mousePressed) {
    while (!video.available ()) {
      video.read();
      video.loadPixels();
    }
    for (int y=0;y<height-1;y++) {
      for (int x=0;x<width-1;x++) {
        hs[x][y]=(int)map(brightness(video.get(x, y)),0,255,50,255);
      }
    }
  };
  for (int y=1;y<height-1;y++) {
    for (int x=1;x<width-1;x++) {
      int res = int(pow(hs[x-1][y]+hs[x+1][y]+hs[x][y-1]+hs[x][y+1], 1.001)/3.8);
      color c = color(res);
      set(x, y, c);
    }
  }
  for (int y=1;y<height-1;y++) {
    for (int x=1;x<width-1;x++) {
      hs[x][y]=(int)brightness(get(x, y));
    }
  }
}
