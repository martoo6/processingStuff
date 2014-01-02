import java.util.Date;
ArrayList<Cutie> cuties = new ArrayList<Cutie>();
PGraphics txt;

void setup() {
  size(1500,500);
  background(50);
  smooth();
  noLoop();
  
  txt= createGraphics(1500,500);
  txt.beginDraw();
  txt.background(255);
  txt.fill(0);
  txt.textSize(300);
  txt.textAlign(CENTER, CENTER);
  txt.text("C U T E", txt.width/2, txt.height/2);
  txt.endDraw();
  
  File[] files = listFiles(sketchPath+"/img/");
  ArrayList<PImage> imgs = new ArrayList<PImage>();
  for(File f:files) imgs.add(loadImage(f.getAbsolutePath()));
  
  for(int i=0;i<300;i++) cuties.add(new Cutie( imgs.get((int)random(imgs.size())) , txt));
}

void draw() {
  imageMode(CENTER);
  for(Cutie c:cuties) c.display();
}

class Cutie
{
  PVector pos;
  float size;
  PImage img; 
  
  
  Cutie(PImage img, PGraphics txt){
    this.img = img;
    
    pos = new PVector();
    pos.x = random(width);
    pos.y = random(height);
    while(brightness(txt.get((int)pos.x,(int)pos.y))>20){
      pos.x = random(width);
      pos.y = random(height);
    }
    size = random(0.5, 0.5);
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(random(-PI/4,PI/4));
    image(img, 0,0, img.width*size, img.height*size);
    popMatrix();
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}
