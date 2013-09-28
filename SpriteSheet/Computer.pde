class Computer implements Observer, Dibujable{
  PImage imagen = loadImage("PC0000.png");
  PVector pos=new PVector((width/2)+random(-width/3,width/3),(height/2)+random(-height/3,height/3));
  long lastTime=-1000;
  String msg = "COMPILA !!";
  
  void hasMoved(Character character){}
  void hasCoded(Character character){
    float dist=dist(this.pos.x,this.pos.y,character.currentPos.x,character.currentPos.y);
    if(dist<40){
      lastTime=millis();
    }
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(imagen,0,0);
    if(millis()-lastTime < 1000) text(msg,50,30);
    popMatrix();
  }
}
