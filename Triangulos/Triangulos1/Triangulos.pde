int i,e;

void setup(){
  size(800,600);
  background(0,0,0);
  smooth();
  noStroke();
  int i,e;
  frameRate(10);
  /*
  for(i=0;i<=800;){
    for(e=0;e<=600;){
      fill(random(255),random(255),random(255));
      triangle(i,e,i+50,e,i,e+50);
      fill(random(255),random(255),random(255));
      triangle(i+50,e+50,i+50,e,i,e+50);
      e=e+50;
    }
    i = i+50;
  }
  */
}

void draw(){
  int i,e;
  for(i=0;i<width;){
    for(e=0;e<height;){
      fill(random(255),random(255),random(255));
      triangle(i,e,i+50,e,i,e+50);
      fill(random(255),random(255),random(255));
      triangle(i+50,e+50,i+50,e,i,e+50);
      e=e+50;
      
    }
    i = i+50;
  }
}
