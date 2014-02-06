
    float ang;
    int curr;
    PImage frames[];
    boolean bLoadDone;

    void setup() {
      size(305, 395);
      background(0);
      smooth();
      noStroke();
      textAlign(CENTER, CENTER);
      frames = new PImage[116];
      bLoadDone = false;
      thread("loadFrames"); // processing convenience method for starting new Thread with a function 
      ang = 0.0;
    }


    void draw() {
      if (bLoadDone) {
        background(0);
        image(frames[curr++], 0, 0);
        if (curr > 115) {
          curr = 0;
        }
      } 
      else {
        float x, y;
        ang += 0.1;
        x = cos(ang) * 8;
        y = sin(ang) * 8;
        fill(0, 8);
        rect(50, 150, 100, 100);
        fill(32, 32, 255);
        ellipse(x + 100, y + 200, 8, 8);
        fill(0);
        rect(120, 150, 170, 100);
        fill(128);
        text(String.format("loading frames (%s of 115)", curr), 200, 200);
      }
    }

    void loadFrames() {
      for (curr = 0; curr < 116; curr++) {
        frames[curr] = loadImage(dataPath(String.format("a%s copy.jpg", nf(curr, 3))));
        delay(75); //just slows down this thread - the main draw() cycle is unaffected...
      }
      curr = 0;
      frameRate(30);
      bLoadDone = true;
    }
