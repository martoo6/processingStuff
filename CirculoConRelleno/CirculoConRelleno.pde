ArrayList triangulos;
final int MAXFORMAS =100;

void setup(){
  size(800,600);
  smooth();
  triangulos = new ArrayList();
  for(int i=0;i<MAXFORMAS;i++){
    triangulos.add(new Triangle(width/2,height/2,200));
  }
}

void draw(){
  background(0);
  for(int i=0;i<triangulos.size();i++){
    Triangle t=(Triangle)triangulos.get(i);
    t.display();
    t.updatePos2D();
  }
}

public class Triangle{
  color myColor = color(random(0,255),random(0,255),random(0,255));
  int radius;
  PVector initPos = new PVector();
  PVector[] pos={new PVector(),new PVector(),new PVector()};
  PVector[] tarjet={new PVector(),new PVector(),new PVector()};
  Triangle(int xPos, int yPos, int radius){
    initPos.x = xPos;
    initPos.y = yPos;
    this.radius = radius;
    float val =random(0,TWO_PI);
    pos[0].x=xPos+cos(val)*radius;
    pos[0].y=yPos+sin(val)*radius;
    val =random(0,TWO_PI);
    pos[1].x=xPos+cos(val)*radius;
    pos[1].y=yPos+sin(val)*radius;
    val =random(0,TWO_PI);
    pos[2].x=xPos+cos(val)*radius;
    pos[2].y=yPos+sin(val)*radius;
    val =random(0,TWO_PI);
    tarjet[0].x=xPos+cos(val)*radius;
    tarjet[0].y=yPos+sin(val)*radius;
    val =random(0,TWO_PI);
    tarjet[1].x=xPos+cos(val)*radius;
    tarjet[1].y=yPos+sin(val)*radius;
    val =random(0,TWO_PI);
    tarjet[2].x=xPos+cos(val)*radius;
    tarjet[2].y=yPos+sin(val)*radius;
  }
  void updatePos2D(){
    pos[0].x+=(tarjet[0].x-pos[0].x)/16;
    pos[0].y+=(tarjet[0].y-pos[0].y)/16;
    pos[1].x+=(tarjet[1].x-pos[1].x)/16;
    pos[1].y+=(tarjet[1].y-pos[1].y)/16;
    pos[2].x+=(tarjet[2].x-pos[2].x)/16;
    pos[2].y+=(tarjet[2].y-pos[2].y)/16;
    if(  (abs(tarjet[0].x-pos[0].x)<10)&(abs(tarjet[0].y-pos[0].y)<10)&
         (abs(tarjet[1].x-pos[1].x)<10)&(abs(tarjet[1].y-pos[1].y)<10)&
         (abs(tarjet[2].x-pos[2].x)<10)&(abs(tarjet[2].y-pos[2].y)<10)
         ){
      float val =random(0,TWO_PI);
      tarjet[0].x=initPos.x+cos(val)*radius;
      tarjet[0].y=initPos.y+sin(val)*radius;
      val =random(0,TWO_PI);
      tarjet[1].x=initPos.x+cos(val)*radius;
      tarjet[1].y=initPos.y+sin(val)*radius;
      val =random(0,TWO_PI);
      tarjet[2].x=initPos.x+cos(val)*radius;
      tarjet[2].y=initPos.y+sin(val)*radius;
    }
  }
  void display(){
    fill(myColor);
    triangle(pos[0].x,pos[0].y,pos[1].x,pos[1].y,pos[2].x,pos[2].y);   
  }
}
