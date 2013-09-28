class Follower implements CharacterBehaviour{
  int threshold=5;
  
  void act(Character me, Character other){
    float dist=dist(me.currentPos.x,me.currentPos.y,other.currentPos.x,other.currentPos.y);
    if(dist<100){
      float signX=0, signY=0;
      if(me.currentPos.x-other.currentPos.x > threshold) signX=-1;
      if(me.currentPos.x-other.currentPos.x < -threshold) signX=1;
      if(me.currentPos.y-other.currentPos.y > threshold) signY=-1;
      if(me.currentPos.y-other.currentPos.y < -threshold) signY=1;
      if(dist>60){      
        me.move(signX*3.5,signY*3.5);
      }
      if(dist<50){
        me.move(-signX*4,-signY*4);
      }
    }
  }
}
