class Wild implements CharacterBehaviour{
  void act(Character me, Character other){
    if(dist(me.currentPos.x,me.currentPos.y,other.currentPos.x,other.currentPos.y)<100){
      me.move(-other.lastMov.x,-other.lastMov.y);
    }
  }
}
