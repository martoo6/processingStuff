class Laptop extends Computer{
  
  Laptop(){
    imagen = loadImage("PC0001.png");
  }
  
  void hasCoded(Character character){
    float dist=dist(this.pos.x,this.pos.y,character.currentPos.x,character.currentPos.y);
    if(dist<50){
      lastTime=millis();
      if(character.rightCode){
        msg="LAPTOP COMPILA !";
      }else{
        msg="SEG FAULT !";
      }
    }
  }
}
