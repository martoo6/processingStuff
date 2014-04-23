float m[][];
float yStep=0.01;
float blobSize=0.01;
void setup() {
  size(300, 300);
  m = new float[width][height];
}

void draw() {
  background(0 );
  for (int x=0;x<width;x++) {
    for (int z=0;z<height;z++) {
      
    }
  }

  
  
    //color c = color(noise(y*8)*255, 0, noise(y*8+50)*255);
    for (int x=0;x<width;x++) {
      for (int z=0;z<height;z++) {
        for (float y=0;y<1;y+=yStep) {
          if (abs(m[x][z]-y)<=blobSize) {
            set(x, z, color(noise(y*8)*255, 0, noise(y*8+50)*255));
          }
        }
        m[x][z]=noise(x*0.01, z*0.01, frameCount*0.01);
      }
    }
}

void keyPressed(){
  if(key=='q') yStep+=0.001;
  if(key=='a') if(yStep>0.001) yStep-=0.001;
  if(key=='w') blobSize+=0.001;
  if(key=='s') if(blobSize>0.001) blobSize-=0.001;
}
