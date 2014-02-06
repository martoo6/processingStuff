import processing.video.*; 

Movie mov; 
boolean cheatScreen; 

int cellSize=10;

char[] drawingChars;

void setup() { 
  
  drawingChars = new char[]{'I', 'J','A' ,'C', 'D', 'G','W'};
  //drawingChars = new char[]{' ', '-','|', 'O','A','#'};
  textSize(10);
  //drawingChars= new char[256];
  //for(int i=0;i<256;i++){
  //  drawingChars[i] = char(i+50);
  //}
  
  // Start capturing the images from the camera 
  mov = new Movie(this, "video.mp4");
  mov.loop();
  if (mov.available()) mov.read();
  mov.volume(0); //Uncomment if you want to hear the audio
 
  background(255); 
  smooth(); 
  fill(0); 
  size(1280, 720); 
} 

void draw() {
  if (mov.available()) {
    mov.read();
    mov.loadPixels();
    background(0); 
    
    for(int i=0;i<width;i+=cellSize){
      for(int e=0;e<height;e+=cellSize){
        color c = mov.get(i,e);
        float b=brightness(c);
        fill(c);
        //fill(255);
        text(getChar(b),i,e);
      }
    }
    
    if(cheatScreen) set(0, 0, mov);
  }
  text(frameRate, 20, 20);
} 

char getChar(float b){
  return drawingChars[round(map(b, 0, 255, 0, drawingChars.length-1))];
}

void keyPressed() { 
  switch (key) { 
  case 'g': 
    saveFrame(); 
    break; 
  case 'c': 
    cheatScreen = !cheatScreen; 
    break;
  }
}
