float large =80;
float rateChange=0.01;
int distPoints=10;
ArrayList<PVector> Hairs = new ArrayList<PVector> (); 
PImage img;
Boolean sf=false;


void setup(){
  img = loadImage("http://www.culture24.org.uk/asset_arena/0/99/88/188990/v0_master.jpg");
  size(img.width,img.height);
  colorMode(HSB);
  background(0 );
  noFill();
  strokeWeight(2);
}

void draw(){
  image(img,0,0);
  for(int i=0;i<Hairs.size();i++){
    beginShape();
    PVector tmpPos = Hairs.get(i);
    curveVertex(tmpPos.x ,tmpPos.y);
    curveVertex(tmpPos.x ,tmpPos.y);
    for(int e=distPoints;e<large;e+=distPoints){
      stroke((255.0/Hairs.size())*i,255,255, 150); //Rainbow Effect
      float x = tmpPos.x + (noise(i,e*rateChange-frameCount*0.01)-0.5)*50; 
      float y = tmpPos.y + e;
      curveVertex(x ,y);
    }
    endShape();
  }
  if(sf) saveFrame("a####.png");
}

void keyPressed(){
  if(key =='s' || key =='S') sf=!sf;
  if(key =='b' || key =='B') Hairs.add(new PVector(mouseX, mouseY));
  if(key =='+') large+=distPoints;
  if(key =='-' && large>=1) large-=distPoints;
}

void mousePressed(){
  Hairs.add(new PVector(mouseX, mouseY));
}
