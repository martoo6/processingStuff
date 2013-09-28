// Class for animating a sequence of GIFs

class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  long lastTime=0;
  int speed;
  float lastX, lastY;

  Animation(String imagePrefix, int count, String extension, int speed) {
    this.speed=speed;
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + extension;
      images[i] = loadImage(filename);
      //images[i].resize(50,0);
    }
  }

  Animation(String fileName, PVector count, PVector origin, PVector step, int speed) {
    this.speed=speed;
    imageCount = (int)(count.x*count.y);
    println(imageCount);
    images = new PImage[imageCount];
    PImage spriteSheet=loadImage(fileName); 

    int i=0;
    for (int y = 0; y < count.y; y++) {
      for (int x = 0; x < count.x; x++) {
        images[i]=spriteSheet.get((int)(x*step.x), (int)(y*step.y), (int)(step.x), (int)(step.y));
        i++;
      }
    }
  }

  void display(float xPos, float yPos) {
    pushMatrix();
    translate(xPos, yPos);
    if (abs(lastX-xPos)>0 || abs(lastY-yPos)>0) {
      if (millis()-lastTime>speed) {
        lastTime=millis();
        frame = (frame+1) % imageCount;
        lastX=xPos;
        lastY=yPos;
      }
      image(images[frame], 0, 0);
    }
    else {
      image(images[0], 0, 0);
    }
    popMatrix();
  }

  int getWidth() {
    return images[0].width;
  }
}

