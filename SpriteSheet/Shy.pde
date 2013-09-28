class Shy implements CharacterBehaviour{
  void act(Character me, Character other){
    if(dist(me.currentPos.x,me.currentPos.y,other.currentPos.x,other.currentPos.y)<70){
      float signX=(me.currentPos.x-other.currentPos.x)/abs(me.currentPos.x-other.currentPos.x);
      float signY=(me.currentPos.y-other.currentPos.y)/abs(me.currentPos.y-other.currentPos.y);
      me.move(signX*2,signY*2);
    }
  }
}
