ArrayList<PImage> splashes = new ArrayList<PImage>();
PImage face;

void setup(){
  size(1024,768);
  face = loadImage("face.jpg");
  face.filter(THRESHOLD);
  
  
  File[] files = listFiles(sketchPath+"/splashes");
  for(File f:files) splashes.add(loadImage(f.getAbsolutePath()));
  
  noLoop();  
}

void draw(){
  background(255);
  //image(face,mouseX,mouseY);
  imageMode(CENTER);
  for(int i=0;i<1000;i++){
    PVector p = new PVector(random(face.width), random(face.height));
    while(brightness(face.get((int)p.x,(int)p.y))>100) p = new PVector(random(face.width), random(face.height));
    pushMatrix();
    translate(p.x, p.y);
    image(splashes.get((int)random(splashes.size()-1)), 0, 0, 80, 80);
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
